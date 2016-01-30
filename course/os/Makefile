CC = gcc
CFLAGS = -Wall -g

LIB = libdarray.a
LDFLAGS = -ldarray -L.

all: $(LIB)

$(LIB): libdarray.o
	ar rcu $(LIB) libdarray.o
	ranlib $(LIB)

.c.o : 
	$(CC) $(CFLAGS) -c $*.c 

clean:
	-rm *.o $(LIB) core
