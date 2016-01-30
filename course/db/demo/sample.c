#ifdef RCSID
static char *RCSid = 
   "$Header: sample.c 6.1.1120.2 93/04/22 19:21:59 agadre Generic<unix> $ sample.c Copyr (c) 1986 Oracle";
#endif /* RCSID */

/*
**
** sample  is a simple example program which adds new employee
**	   records  to the  personnel  data base.  Checking is
**	   done to insure the integrity of the data base.  The
**	   employee numbers  are automatically	selected using
**	   the	current maximum  employee number as the start.
**	   If  any  employee  number  is  a  duplicate,  it is
**	   skipped.  The  program queries the user for data as
**	   follows:
**	       Enter employee name:
**	       Enter employee job:
**	       Enter employee salary:
**	       Enter employee dept:
**
**	   The program terminates if EOF (end of file) or a null
**	   string (<return> key) is entered when the employee name
**	   is requested.
**
**	   If a record is successfully inserted, the following
**	   is printed:
**
**	   ename added to department dname as employee # nnnnnn
**
**	   The new employee number is 10 more than the highest
**	   previous employee number.
**
** UNIX COMPILING/LINKING INSTRUCTIONS:
**         $ make -f proc.mk sample
*/

#include <stdio.h>
#include <ctype.h>
/*
** DEFINE THE c VERSION OF THE CURSOR (FOR 32 BIT MACHINES)
*/
struct csrdef
{
   short	  csrrc;				  /* return code */
   short	  csrft;				/* function type */
#if defined(__osf__) && defined(__alpha)
   unsigned int  csrrpc;			 /* rows processed count */
#else
   unsigned long  csrrpc;			 /* rows processed count */
#endif
   short	  csrpeo;			   /* parse error offset */
   unsigned char  csrfc;				/* function code */
   unsigned char  csrfil;				      /* filler  */
   unsigned short csrarc;			    /* reserved, private */
   unsigned char  csrwrn;				/* warning flags */
   unsigned char  csrflg;				  /* error flags */
   /*		     *** Operating system dependent *** 		 */
   unsigned int   csrcn;				/* cursor number */
   struct {					      /* rowid structure */
     struct {
#if defined(__osf__) && defined(__alpha)
	unsigned int	tidtrba;	   /* rba of first blockof table */
#else
	unsigned long	tidtrba;	   /* rba of first blockof table */
#endif
	unsigned short	tidpid; 		/* partition id of table */
	unsigned char	tidtbl; 		    /* table id of table */
	}		ridtid;
#if defined(__osf__) && defined(__alpha)
     unsigned int   ridbrba;			     /* rba of datablock */
#else
     unsigned long   ridbrba;			     /* rba of datablock */
#endif
     unsigned short  ridsqn;	      /* sequence number of row in block */
     } csrrid;
   unsigned int   csrose;		      /* os dependent error code */
   unsigned char  csrchk;				   /* check byte */
   unsigned char  crsfill[26];		       /* private, reserved fill */
#if defined(__osf__) && defined(__alpha)
   unsigned long  filler;           /* ensure alignment if used in array */
#endif
};
#define UCP(x) ((unsigned char *)(x))

char *uid = "scott/tiger";                          /* username/password */
char *insert = "INSERT INTO EMP(EMPNO, ENAME, JOB, SAL, DEPTNO) VALUES \
		(:EMPNO, :ENAME, :JOB, :SAL, :DEPTNO)";
char *cselect = "SELECT DNAME FROM DEPT WHERE DEPTNO=:1";
char *maxemp = "SELECT NVL(MAX(EMPNO), 0) + 10 FROM EMP";
char *selemp = "SELECT ENAME, JOB FROM EMP";     /* find ename, job size */


main()
{
   int	  empno, sal, deptno;	 /* employee number, salary, dept number */
   int    tmpc;
   struct csrdef lda;					     /* lda area */
   struct csrdef curs[2];			      /* and two cursors */
#if defined(__osf__) && defined(__alpha)
   char   hst[512];				      /* Host definition */
#else
   char   hst[256];				      /* Host definition */
#endif
   char   *ename, *job, *dept;		   /* employee name,job and dept */
   short  enamelmax, enamel, joblmax, jobl, deptl;
   char   *malloc();

#define LDA &lda
#define C0  (&curs[0])
#define C1  (&curs[1])
#define HST hst
#define DUPLICATE_VALUE -9		    /* HLI interface return code */
#define INT 3					/* HLI integer type code */
#define CHRSTR 5		      /* HLI null terminated string type */
/*
** LOGON TO ORACLE, OPEN TWO CURSORS.  NOTE: IN MOST SITUATIONS,
** THIS SIMPLE PROGRAM EXITS IF ANY ERRORS OCCUR.
*/
   if (orlon(LDA, HST, uid, -1, (char *)0, -1, -1))
   {
      errlda(LDA, "orlon");
      goto errexit;
   }

   if (oopen(C0, LDA, (char *)0, -1, -1, (char *)0, -1))
   {
      errrpt(C0);
      goto errexit;
   }

   if (oopen(C1, LDA, (char *)0, -1, -1, (char *)0, -1))
   {
      errrpt(C1);
      goto errexit;
   }

/*
** TURN OFF AUTO-COMMIT.  NOTE: THE DEFAULT IF OFF, SO THIS COULD
** BE OMMITTED.
*/
   if (ocof(LDA))
   {
      errlda(LDA, "ocof");
      goto errexit;
   }
/*
** RETRIEVE THE CURRENT MAXIMUM EMPLOYEE NUMBER
*/
   if (osql3(C0, maxemp, -1)
       || odefin(C0, 1, UCP(&empno), sizeof(empno),
	  INT, -1, (short *)0, (char *)0, -1, -1, (short *)0, (short *)0)
       || oexec(C0)
       || ofetch(C0))
   {
      errrpt(C0);
      goto errexit;
   }

/*
** DESCRIBE THE COLUMNS TO DETERMINE THE MAX LENGTH OF
** THE EMPLOYEE NAME, JOB TITLE.
*/
   if (osql3(C0, selemp, -1)
       || odsc(C0, 1, &enamelmax, (short *)0, (short *)0, (short *)0,
	       (char *)0, (short *)0, (short *)0)
       || odsc(C0, 2, &joblmax,   (short *)0, (short *)0, (short *)0,
	       (char *)0, (short *)0, (short *)0) )
   {
      errrpt(C0);
      goto errexit;
   }

   job	 = malloc(joblmax+1);		   /* don't forget room for null */
   ename = malloc(enamelmax+1);

/*
** PARSE THE INSERT AND SELECT STATEMENTS
** DESCRIBE dname SO THAT WE CAN ALLOCATE SPACE
** THEN DEFINE dept
*/
   if (osql3(C0, insert, -1))
   {
      errrpt(C0);
      goto errexit;
   }

   if (osql3(C1, cselect, -1)
       || odsc(C1, 1, &deptl, (short *)0, (short *)0, (short *)0,
	    (char *)0, (short *)0, (short *)0)
       || odefin(C1, 1, dept = malloc(deptl+1) , deptl+1, CHRSTR,
	    -1, (short *)0, (char *)0, -1, -1, (short *)0, (short *)0) )
   {
      errrpt(C1);
      goto errexit;
   }

/*
** BIND SQL SUBSTITUTION VARIABLE VALUES USING BIND BY REFERENCE
** STATEMENTS.
*/

   if (   obndrv(C0, ":ENAME", -1, ename, (int)enamelmax+1, CHRSTR,
	     -1, (short *)0, (char *)0, -1, -1)
       || obndrv(C0, ":JOB", -1, job, (int)joblmax+1, CHRSTR,
	     -1, (short *)0, (char *)0, -1, -1)
       || obndrv(C0, ":SAL", -1, UCP(&sal), sizeof(sal),
	     INT, -1, (short *)0, (char *)0, -1, -1)
       || obndrv(C0, ":DEPTNO",-1, UCP(&deptno), sizeof(deptno),
	     INT, -1, (short *)0, (char *)0, -1, -1)
       || obndrv(C0, ":EMPNO", -1, UCP(&empno),  sizeof(empno),
	     INT, -1, (short *)0, (char *)0, -1, -1) )
   {
      errrpt(C0);
      goto errexit;
   }

/*
** READ THE USER'S INPUT FROM stdin.  IF THE EMPLOYEE NAME IS
** NOT ENTERED, THEN EXIT.  VERIFY THAT THE ENTERED DEPARTMENT
** NUMBER IS VALID AND ECHO THE DEPARTMENT'S NAME WHEN DISPLAYING
** THE NEW ROW.
*/

   for ( ; ; ) {
      enamel = asks("Enter employee name  : ",ename,(int)enamelmax+1);
      if ( enamel == enamelmax && ename[enamel] != '\n' ) {
         printf("Name too long; truncated to \"%s\"\n",ename);
         while ( (tmpc=getchar() ) != '\n' )
            ;
      }
      else {
         ename[--enamel]='\0';
      }
      if ( enamel <= 0 )
         break;
      jobl = asks("Enter employee job   : ",job,(int)joblmax+1);
      if ( jobl == joblmax && job[jobl] != '\n' ) {
         printf("Job title too long; truncated to \"%s\"\n",job);
         while ( (tmpc=getchar() ) != '\n' )
         ;
      }
      else {
         job[--jobl]='\0';
         }
      askn("Enter employee salary: ",&sal);
      do {
         if (askn("Enter employee dept  :   ",&deptno) < 0 )
	    goto errexit;
	 if (obndrn(C1, 1, UCP(&deptno), sizeof(deptno),
	     INT, -1, (char *)0, -1, -1)
	  || oexec(C1)
	  || ofetch(C1))
	 {
	    printf("\nNo such department %d\n", deptno);
	    deptno = -1;
	 }
      } while (deptno == -1);

/*
** EXECUTE THE STATEMENTS.  IF A DUPLICATE empno OCCURS, CALCULATE THE
** NEXT ONE AND EXECUTE AGAIN.
*/
      while (oexec(C0) == DUPLICATE_VALUE)
      {
	 empno += 10;
      }

/*
** IF ANY ERROR FROM OEXEC OCCURS AT THIS POINT, EXIT.
*/
      if (C0->csrrc)
      {
	 errrpt(C0);
	 goto errexit;
      }

/*
** COMMIT THE CHANGE TO THE DATABASE.
*/
      if (ocom(LDA))
      {
	 errlda(LDA, "ocom");
	 goto errexit;
      }

/*
** GIVE THE USER SOME FEEDBACK.
*/
      printf("\n%s added to the %s department as employee number %d\n",
	     ename, dept, empno);
      empno += 10;
   }

/*
** EITHER AN ERROR, OR USER ENTERED END-OF-FILE FOR EMPLOYEE NAME.
** CLOSE THE CURSORS AND LOG OFF FROM ORACLE.
*/

errexit:
   oclose(C0);
   oclose(C1);
   ologof(LDA);
   printf ("\nEnd of the C/ORACLE example program.\n");
   exit(0);
}

/*
** errlda AND errrpt PRINT THE ERROR CODE, OTHER INFORMATION.
*/

/*void*/ errrpt(cur)
struct csrdef *cur;				    /* pointer to cursor */
{
   char  msg[80];
   printf("ORACLE error: code is %d, op is %d\n",
	  (int)cur->csrrc, (int)cur->csrfc);
   oermsg(cur->csrrc, msg);
   printf("%s\n",msg);
}

/* void */ errlda(lda,msg)
struct	csrdef *lda;				   /* pointer to the LDA */
char	msg[];				       /* user specified message */
{
   char    oertxt[80];
   printf ("LDA error (%s): code is %d\n", msg, (int)lda->csrrc);
   oermsg(lda->csrrc, oertxt);
   printf("%s\n",oertxt);
}

/*
**
** int askn(text,variable)
**
**  print the 'text' on STDOUT and read an integer variable from
**  SDTIN.
**
**  text points to the null terminated string to be printed
**  variable points to an integer variable
**
**  askn returns a 1 if the variable was read successfully or a
**      -1 if -eof- was encountered
*/

int askn(text,variable)
   char text[];
   int	*variable;
{
   char s[20];
   int len,tmpc;

   printf(text);
   if ( fgets(s,20,stdin) == (char *)0 )
     return(EOF);
   len=strlen(s);

   if ( len == 19 && s[len-1] != '\n' ) {
      printf("Value too long; truncated to \"%s\"\n",s);
      while ( (tmpc=getchar() ) != '\n' )
         ;
   }
   else {
      s[len-1]='\0';
      len--;
   }

   *variable = atoi(s);
   return(1);
}

/*
** int asks(text,variable)
**
**  print the 'text' on STDOUT and read up to 'len' characters into
**  the buffer pointed to by variable from STDIN.
**
**  text points to the null terminated string to be printed
**  variable points to a buffer of at least 'len'+1 characters
**
**   asks returns the number of character read into the string, or a
**       -1 if -eof- was encountered
*/

int asks(text,variable,vlen)
   char text[],variable[];int vlen;
{
   printf(text);
   return( fgets(variable,vlen,stdin) == (char *)0 ? EOF : strlen(variable) );
}
