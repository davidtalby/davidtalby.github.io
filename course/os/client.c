/* Example of using Internet TCP/IP sockets: The client size */
/* The client connects to the server, sends "Hello, World!" and disconnects. */

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>

#define BUF_SIZE 13
#define ERROR (-1)
#define PERROR(msg) { perror(msg); exit(1); }
#define HERROR(msg) { herror(msg); exit(1); }

int main(int argc, char *argv[])
{
  int sfd = -1;                     /* fd of current physical connection */
  int count, done = 0;              /* how many bytes were sent to the server  */
  struct sockaddr_in saddr;         /* socket addr info of server */
  struct hostent *hstent;           /* host entry data */
  char buf[BUF_SIZE+1];             /* holds string to send to server */
  int port;

  /* Check command line arguments */
  if (argc != 3) {
    fprintf(stderr, "Usage: client <host> <port>\n");
    exit(1);
  }
  port = atoi(argv[2]);

  /* Fill the sockaddr fields */
  bzero(&saddr, sizeof(saddr));
  saddr.sin_family = AF_INET;
  saddr.sin_port = htons(port);
  if ((hstent = gethostbyname(argv[1])) == NULL)
    HERROR("gethostbyname");
  bcopy((char *)hstent->h_addr, (char *)&(saddr.sin_addr.s_addr), hstent->h_length );

  /* Contact the Server */
  if ((sfd = socket(PF_INET,SOCK_STREAM,0) ) == ERROR)
    PERROR("socket");
  if (connect(sfd, (struct sockaddr*)&saddr, sizeof(saddr) ) == ERROR)
    PERROR("connect");

  /* Write the famous string to the server */
  /* In your exercise, your should encapsulate these lines in a write_n function */
  strcpy(buf, "Hello, World!");
  done = 0;
  while (BUF_SIZE - done > 0) {
    if ((count = write(sfd, &(buf[done]), BUF_SIZE - done) ) == ERROR)
      PERROR("write");
    done += count;
  }

  /* Close the connection */
  close(sfd);
}
