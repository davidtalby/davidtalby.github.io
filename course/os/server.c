/* Example of using Internet TCP/IP sockets: The server size */
/* The server listens forever for requests; when someone connect, it read 13 characters
   from the socket, prints them on the screen, and closes the connection. */

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <errno.h>

#define BUF_SIZE 13
#define ERROR (-1)
#define PERROR(msg) { perror(msg); exit(1); }

/* Global variables */
struct sockaddr_in saddr;
int sfd;

/* Handles a request from a client. In a busy server this function will usually
   fork or create a new thread so that the server could return to the main loop. */
void handle_request(int fd)
{
  char buf[BUF_SIZE+1];
  int count, done;

  /* Read exactly BUF_SIZE bytes from the client, and print them to the screen */
  /* In your exercise, your should encapsulate these lines in a read_n function */
  done = 0;
  while (BUF_SIZE - done > 0) {
    if ((count = read(fd, &(buf[done]), BUF_SIZE - done)) == ERROR)
      PERROR("read");
    done += count;
  }
  
  /* Print string to the standard output, and close the connection */
  buf[BUF_SIZE] = '\0';
  printf("Client Sent: %s\n", buf);
  close(fd);
}

/* Initialize server to listen to the given port */
void init(char *portname)
{
  if ((sfd = socket(PF_INET, SOCK_STREAM, 0)) == ERROR) PERROR("socket");
  bzero(&saddr, sizeof(saddr));
  saddr.sin_family = AF_INET;
  saddr.sin_port = htons(atoi(portname));
  saddr.sin_addr.s_addr = INADDR_ANY;
  if (bind(sfd,(struct sockaddr*)&saddr, sizeof(saddr)) == ERROR) PERROR("bind");
  if (listen(sfd, 5) == ERROR) PERROR("listen");
}

/* Wait for client requests forever, and pass them to handle_request() when they come */
void mainloop()
{
  int l = sizeof(saddr);
  int fd = -1;
  
  for (;;)  {
    do { fd = accept(sfd, (struct sockaddr*)&saddr, &l); }
      while (fd==ERROR && errno==EINTR);
    if (fd==ERROR) PERROR("accept");
    handle_request(fd);
    close(fd);
  }
}

/* Main function - check argument, initialize server and call mainloop() */
int main(int argc, char *argv[])
{
  if (argc!=2) {
    fprintf(stderr,"Usage:  server <port>\n");
    exit(1);
  }
  init(argv[1]);
  mainloop();
  exit(1);
}
