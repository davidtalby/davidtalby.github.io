#ifndef _HFTP_H_
#define _HFTP_H_

/* Includes the error code for the last library function call.
   0 means no error, other values are undefined. */
extern int hftp_errno;

/* Initialize a connection to the server at the given host name and port.
   This function must be called before any other function. */
int hftp_open(const char *host, unsigned short port);

/* Close the current connection to the server.
   This must be the last function to be called on an open connection,
   however afterwards it is possible to open a new different connection. */
int hftp_close(void);

/* Read the file named remote_file on the server's host into the file named
   local_file on this computer. Returns an error if local_file already exists.
   remote_file should be a regular file or a symbolic link (in which case the
   regular file the link points to will be received). */
int hftp_getfile(const char *remote_file, const char *local_file);

/* Write the file named local_file on this computer to a file named remote_file
   on the server's host. Returns an error if remote_file already exists on the
   server host. local_file should be a regular file or a symbolic link (in which
   case the regular file the link points to will be sent). */
int hftp_putfile(const char *local_file, const char *remote_file);

/* Rename or move a remote file. If old_remote_file doesn't exist or
   new_remote_file exists on the server host, it is an error. */
int hftp_movfile(const char *old_remote_file, const char *new_remote_file);

/* Change the current working directory on the server for this connection.
   The default working directory of each new connection is the directory
   the server was started from. */
int hftp_cwd(const char *remote_dir);

/* Return the current remote working directory into buf, up to buflen bytes.
   'buf' should be allocated memory of at least buflen bytes. If the remote
   working directory is more than buflen bytes long, an error is reported. */
int hftp_pwd(const char *buf, int buflen);

/* Read the list of files in a directory on the server into a file named
   local_file on this computer. An error is reported if local_file exists.
   The created local file will contain exactly the output of running "ls"
   on the given remote_dir on the server. */
int hftp_ls(const char *remote_dir, const char *local_file);

/* Read the list of files in a directory on the server into a file named
   local_file on this computer. An error is reported if local_file exists.
   The created local file will contain exactly the output of running "ls -l"
   on the given remote_dir on the server. */
int hftp_dir(const char *remote_dir, const char *local_file);

/* This function prints to the standard error the given argument s, followed
   by a colon, a space, a detailed error message, and a newline character.
   The error message is based on the current value of the variable hftp_errno.
   This functions also sets that variable to zero. */
void hftp_error(const char *s);

#endif

