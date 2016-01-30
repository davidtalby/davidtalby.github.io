# 
# $Header: proc.mk.pp 7.27 93/08/09 10:37:24 hma Osd<unix> $ proc.mk.pp
# 

#
# proc.mk - Command file for "make" to compile and load OCI and Pro*C programs.
#
# Pro*C programs are assumed to have the extension ".pc"
#
#
# Usage for sample OCI program: 
#	make -f proc.mk sample
# Usage for sample Pro*C program: 
#	make -f proc.mk samplec
#

SHELL=/bin/sh

LIBHOME=$(ORACLE_HOME)/lib

CC=/usr/5bin/cc

CFLAGS=-I. -O

LDFLAGS=-Bdynamic -L$(LIBHOME)

ARLOCAL=

AR=ar $(ARLOCAL)
ARCREATE=ar cr$(ARLOCAL)
ARDELETE=ar d$(ARLOCAL)
ARREPLACE=ar r$(ARLOCAL)

RANLIB=ranlib

RANLIBL=; $(RANLIB)

ECHO=$(ORACLE_HOME)/bin/echodo

PCC=$(ORACLE_HOME)/bin/pcc
PCCINC=$(ORACLE_HOME)/proc/lib
PCCFLAGS=include=$(PCCINC) ireclen=132 oreclen=132 select_error=no

PROC=$(ORACLE_HOME)/bin/proc
PROFOR=$(ORACLE_HOME)/bin/profor
PROCOB=$(ORACLE_HOME)/bin/procob
PROPAS=$(ORACLE_HOME)/bin/propas
PROADA=$(ORACLE_HOME)/bin/proada

PROFLAGS=ireclen=132 oreclen=132 select_error=no $(SQLCHECK) $(PROUSER)

LIBCORE=$(LIBHOME)/libcore.a

LIBCV6=$(LIBHOME)/libcv6.a

LIBNLSRTL=$(LIBHOME)/libnlsrtl.a

LLIBCORE=-lcore

LLIBCV6=-lcv6

LLIBNLSRTL=-lnlsrtl

LIBORA=$(LIBHOME)/libora.a 
LLIBORA=-lora

LIBSQLDBA=$(LIBHOME)/libsqldba.a

LIBSQL=$(LIBHOME)/libsql.a

LIBOCIC=$(LIBHOME)/libocic.a

LIBPCC=$(LIBHOME)/libpcc.a

LIBPSD=$(LIBHOME)/libpsd.a

LIBOSDGEN=$(LIBHOME)/libosdgen.a

LIBPLUS=$(LIBHOME)/libsqlplus.a

LIBPLS=$(LIBHOME)/libpls.a

LIBKNL=$(LIBHOME)/libknl.a

LIBFORMS=$(LIBHOME)/libforms.a

LIBFORMS30=$(LIBHOME)/libforms30.a

LIBFORMS30P=$(LIBHOME)/libforms30p.a

LIBFORMS30C=$(LIBHOME)/libforms30c.a

LIBFORMS30X=$(LIBHOME)/libforms30x.a

LIBFORMS30M=$(LIBHOME)/libforms30m.a

LIBOKT=$(LIBHOME)/libokt.a

LIBOKTC=$(LIBHOME)/liboktc.a

LIBOKTX=$(LIBHOME)/liboktx.a

LIBOKTM=$(LIBHOME)/liboktm.a

OTHERLIBS=`cat $(ORACLE_HOME)/rdbms/lib/sysliblist` $(MLSLIBS)

LLIBPSO=

LLIBPSO=-lstublm

LIBSQLNET=$(LIBHOME)/libsqlnet.a
LLIBSQLNET=-lsqlnet

LIBTCP=$(LIBHOME)/libtcp.a

LIBNETWORK=$(LIBHOME)/libnetwork.a

LIBNETV2=$(LIBHOME)/libnetv2.a

LIBNTTCP=$(LIBHOME)/libnttcp.a

CONFIG=$(LIBHOME)/config.o

OSNTAB=$(LIBHOME)/osntab.o

OSNTABST=$(LIBHOME)/osntabst.o

FORMS30GUILIBS=

OSNTLPTB=$(LIBHOME)/osntlptb.o

NTCONTAB=$(LIBHOME)/ntcontab.o

CORELIBS=$(LLIBNLSRTL) $(LLIBCV6) $(LLIBCORE) $(LLIBNLSRTL) $(LLIBCV6) \
    $(LLIBCORE)
CORELIBD=$(LIBNLSRTL)  $(LIBCV6)  $(LIBCORE)

NETV2LIBS=$(LLIBSQLNET)
NETV2LIBD=$(LIBSQLNET)

NETLIBS=$(OSNTAB) $(LLIBSQLNET)
NETLIBD=$(OSNTAB) $(LIBSQLNET)

TTLIBD= $(NETLIBD)  $(LIBORA) $(CORELIBD)
TTLIBS= $(NETLIBS) $(LLIBORA) $(LIBPLSHACK) $(LLIBSQLNET) $(CORELIBS)\
    $(FORMS30GUILIBS) $(CLIBS)

PLSPECFILES=

STLIBS=$(OSNTABST) $(CONFIG) $(PLSPECFILES) -lora -lknlopt $(LIBPLS) -lknl \
       -lora -lknlopt $(LIBPLS) -lknl $(NETV2LIBS) -lora $(CORELIBS) \
       $(LLIBPSO) $(CLIBS)

STLIBD=$(LIBORA) $(LIBKNLOPT) $(LIBPLS) $(LIBKNL) $(NETV2LIBD) $(CORELIBD)

LIBTLI=$(OSNTLPTB) $(LLIBSQLNET)

PROLIBS=-locic -lsql

PCCLIBS=-lpcc -lsql -locic -lpcc

FRMLIBS=$(LIBHOME)/scp.o -lforms

TK2HOME = $(ORACLE_HOME)/guicommon/tk2

CTK2LIBS= $(LIBTK2C) $(LIBTK2OT) $(LIBTK2REM) $(LIBTK2RM) $(LIBTK2UT) \
       $(LIBTK2C) $(LIBTK2P) $(LIBTK2ROS) $(LIBTK2SL)

LIBCA = $(LIBHOME)/libca.a
LIBDE = $(LIBHOME)/libde.a
LIBGRAPHICS = $(LIBHOME)/libgraphics.a
LIBHH = $(LIBHOME)/libhh.a
LIBMMMM = $(LIBHOME)/mmmm.a
LIBMMOI = $(LIBHOME)/liboi.a
LIBMMOS = $(LIBHOME)/libos.a
LIBNN = $(LIBHOME)/libnn.a
LIBNNP = $(LIBNN) $(LIBHOME)/nntppb.o $(LIBHOME)/nntpps.o
LIBOACORE = $(LIBHOME)/liboacore.a
LIBOCL = $(LIBHOME)/libocl.a
LIBPLS11 = $(LIBHOME)/libpls11.a
LIBPSD11 = $(LIBHOME)/libpsd11.a
LIBRWS = $(LIBHOME)/librws.a
LIBSRWBM = $(LIBHOME)/libsrwbm.a
LIBSRWCM = $(LIBHOME)/libsrwcm.a
LIBSRWII = $(LIBHOME)/libsrwii.a
LIBSRWMV = $(LIBHOME)/libsrwmv.a
LIBSRWTO = $(LIBHOME)/libsrwto.a
LIBSSL = $(LIBHOME)/libssl.a
LIBTK2C = $(LIBHOME)/libtk2c.a
LIBTK2M = $(LIBHOME)/libtk2m.a $(LIBHOME)/libtk2p.a $(LIBHOME)/libtk2m.a
LIBTK2OT= $(LIBHOME)/libot.a
LIBTK2P = $(LIBHOME)/libtk2p.a
LIBTK2RE = $(LIBHOME)/libre.a
LIBTK2REM= $(LIBHOME)/librem.a
LIBTK2ROS = $(LIBHOME)/libros.a
LIBTK2SL = $(LIBHOME)/libsl.a
LIBTK2UC = $(LIBHOME)/libuc.a
LIBTK2UT = $(LIBHOME)/libut.a
LIBTK2UTIL = $(LIBHOME)/libutil.a
LIBTK2X = $(LIBHOME)/libtk2x.a
LIBVGS = $(LIBHOME)/libvgs.a
LIBZOM = $(LIBHOME)/libzom.a

XLIBS=-lXaw -lXt -lXmu -lXext -lX11 -lm

XLIBHOME = /usr/lib
MOTIFLIBHOME = /usr/lib
MOTIFLIBS = -L$(MOTIFLIBHOME) -lXm -L$(XLIBHOME) -lXt -lX11 -lm

MOTIFLIBS= -L$(MOTIFLIBHOME) -lXm -L$(XLIBHOME) -lXt -lX11 -lm -Bdynamic -ldl

OPENWINHOME=/usr/openwin
OLLIBHOME=$(OPENWINHOME)/lib
OWLIBS=-L$(OPENWINHOME)/lib -lXol -lXt -lX11 -lm

OLLIBS=-L$(OLLIBHOME) -lXol -lXt -lX11 -lm

CLIBS=$(OTHERLIBS)

#
# NOTE:   ORACLE_HOME must be either:
#		. set in the user's environment
#		. passed in on the command line
#		. defined in a modified version of this makefile
#

.SUFFIXES: .exe .o .c .pc

USERID = scott/tiger

#
# Define V6 and V7 specific macros here.
#
# Following macros contain ORACLE libraries that are linked to create:
# PROLDLIBS 	  : Pro*C application executables
# OCILDLIBS 	  : OCI application executables
# STPROLDLIBS 	  : single-task Pro*C application executables (no PL/SQL)
# STOCILDLIBS 	  : single-task OCI application executables (no PL/SQL)
# STPROLDLIBS_PLS : single-task Pro*C application executables (using PL/SQL)
# STOCILDLIBS_PLS : single-task OCI application executables (using PL/SQL)
#

LIBORAST=-lora -lknlopt -lpls -lpsd -lknl -lora -lknlopt -lpls -lpsd -lknl \
        $(NETV2LIBS) -lora
LIBORASTD=$(LIBORA) $(LIBKNLOPT) $(LIBPLS) $(LIBKNL) $(NETV2LIBD) $(LIBCORE)

LIBPROC= $(ORACLE_HOME)/proc/lib/libproc.a
LIBCGEN= $(ORACLE_HOME)/proc/lib/libcgen.a
PROCLIBS= $(LIBSQL) $(LIBPROC) $(LIBPCC) $(LIBCGEN) $(LIBOSDGEN) $(LIBPSD)
LIBPLSHACK= $(LIBPLS)

PROLDLIBS= $(LIBSQL) $(TTLIBS)
OCILDLIBS= $(LIBOCIC) $(TTLIBS)

STLDLIBS= $(STLIBS) $(LIBORAST) $(LIBCORE)
STPROLDLIBS= $(LIBSQL) $(STLDLIBS)
STOCILDLIBS= $(LIBOCIC) $(STLDLIBS)

STLDLIBS_PLS= $(STLDLIBS)
STPROLDLIBS_PLS= $(LIBSQL) $(STLDLIBS_PLS)
STOCILDLIBS_PLS= $(LIBOCIC) $(STLDLIBS_PLS)

all: sample samplec

sample: sample.o
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $@.o $(OCILDLIBS)

samplec: samplec.c samplec.pc
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ samplec.c $(PROLDLIBS)

samplest: sample.o
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $? $(STOCILDLIBS_PLS) $(CLIBS)

samplecst: samplec.c samplec.pc
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) samplec.c -o $@ $(STPROLDLIBS_PLS) $(CLIBS)

.pc.c:
	$(PROC) $(PROFLAGS) iname=$*.pc 

LIBDIR= $(ORACLE_HOME)/proc/lib
DEMODIR= $(ORACLE_HOME)/proc/demo

install_files:
	-rm -f $(LIBDIR)/ORACA.H
	-rm -f $(LIBDIR)/SQLCA.H
	-rm -f $(LIBDIR)/SQLDA.H
	-rm -f $(DEMODIR)/proc.mk
	-ln $(LIBDIR)/oraca.h $(LIBDIR)/ORACA.H
	-ln $(LIBDIR)/sqlca.h $(LIBDIR)/SQLCA.H
	-ln $(LIBDIR)/sqlda.h $(LIBDIR)/SQLDA.H
	-ln $(LIBDIR)/proc.mk $(DEMODIR)/proc.mk

install: clean proc
	-chmod 755 $(ORACLE_HOME)/bin/proc
	-mv proc $(ORACLE_HOME)/bin/proc
	-chmod 755 $(ORACLE_HOME)/bin/proc

clean:
	-rm -f proc

proc: $(PROCLIBS) $(LIBORA) $(NETLIBD) $(LIBPLS) $(LIBPSD)
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) -o $@  $(PROCLIBS) \
	$(LIBPLS) $(LIBPSD) $(TTLIBS)

procst: $(PROCLIBS) $(LIBORA) $(STLIBD) $(LIBPLS)
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) -o $@  $(PROCLIBS) $(OSNTABST) \
	$(CONFIG) $(LIBORAST) $(LIBCORE) $(CLIBS)

singletask: procst
	-mv procst $(ORACLE_HOME)/bin/procst
	-chmod 755 $(ORACLE_HOME)/bin/procst

#
# General suffix rule to build executables from .pc and .c files.
#
# Usage :
# 	make -f proc.mk USERID=<user/pass> <prog>
#
# For example to build an executable from a Pro*C source file named 'abc.pc' 
# using scott/tiger for the ORACLE account name.  The make command line will 
# be:
# 	make -f proc.mk USERID=scott/tiger abc
#
# Note:  scott/tiger is the default account/password, so that you could
#        also use the following command line:
#
#	make -f proc.mk abc
#
# The executable will be named 'abc'.
#

.pc:
	-$(PROC) iname=$*.pc $(PROFLAGS)
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) -o $* $*.c $(PROLDLIBS) 

.c:
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) -o $* $*.c $(PROLDLIBS) 

#
# A Pro*C demo that that uses dynamic SQL to execute arbitray
# interactive SQL commands.
#

dsql: dsql.c dsql.pc
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) dsql.c -o $@ $(PROLDLIBS)

#
# Sample Pro*C demo programs with PL/SQL blocks.
#
PLSPCCFLAGS = ireclen=132 oreclen=132 sqlcheck=semantics userid=plsqa/supersecret

examp6: examp6.pc
	$(PROC) iname=$@.pc $(PLSPCCFLAGS) 
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) examp6.c -o $@ $(PROLDLIBS)

examp7: examp7.pc
	$(PROC) iname=$@.pc $(PLSPCCFLAGS) 
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) examp7.c -o $@ $(PROLDLIBS)

bankdemo:bankdemo.pc
	$(PROC) iname=$@.pc $(PLSPCCFLAGS) 
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) bankdemo.c -o $@ $(PROLDLIBS)

sample5: sample5.pc
	$(PROC) iname=$@.pc $(PLSPCCFLAGS) 
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) sample5.c -o $@ $(PROLDLIBS)

#
# Sample Pro*C user-exits.
#

UXTLDLIBS= $(ORACLE_HOME)/forms30/lib/iaddrvc.o \
	$(ORACLE_HOME)/forms30/lib/ifmdmf.o \
	$(ORACLE_HOME)/forms30/lib/ifplut.o \
	$(LIBFORMS30C) $(LIBFORMS30) $(LIBFORMS30P) $(LIBOKTC) $(LIBOKT) \
	$(ORACLE_HOME)/forms30/lib/libpls.a $(LIBFORMS30C) $(LIBFORMS30) \
	$(LIBOCIC) $(LIBSQL) $(TTLIBS)

concat: concat.pc
	$(PROC) $(PROFLAGS) iname=concat.pc
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) -o concat concat.c $(UXTLDLIBS)

sample5uxt: sample5uxt.pc
	$(PROC) iname=sample5uxt.pc $(PROFLAGS)
	@$(ECHO) $(CC) $(CFLAGS) $(LDFLAGS) -o sample5uxt sample5uxt.c \
	$(UXTLDLIBS)

