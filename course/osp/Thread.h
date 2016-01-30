// Operating Systems Project, Hadassah College, 2000
// Thread information class

#ifndef THREAD_H_
#define THREAD_H_

#include "Semaphore.h"


class Thread
{
public:

  // constructor. 'func' is the code the thread should run.
  // 'arg' is an argument passed to 'func', or NULL if 'func' doesn't expect an argument.
  Thread(void (*func)(void*), void *arg);

  // destructor
  virtual ~Thread();

  // delay execution for a given number of milliseconds
  void delay(int msec);
  
  // yield CPU time to other threads
  void yield();
  
  // terminate execution (this is a non-reversible action)
  // for the first thread, this exits the entire process
  // for threads created with start, other threads keep running
  void stop();
  
  // delay until this thread is the only thread in the system
  // should only be called by the first thread
  void wait_all();

  // grow the thread's stack in memory by a given number of bytes
  // returns new stack size
  int grow_stack(int nbytes);
  
  // grow the thread's stack in memory by a given number of bytes
  // returns new stack size
  // does not reduce stack size below what is currently used
  int shrink_stack(int nbytes);

  // the total allocated stack size for the thread (in bytes)
  int get_stack_size();
  
  // the number of used bytes in the thread's stack
  int get_used_stack_size();

  // initial stack size in bytes
  static const int INITIAL_STACK_SIZE = 16384;

protected:

  // suspend this thread until 'resume' is called
  // this function should only be used by semaphores
  virtual void suspend();
  
  // resume this thread, assuming it was previously suspended
  // this function should only be used by semaphores
  virtual void resume();
  
  // semaphores need access to 'suspend' and 'resume'
  friend class Semaphore;
}


#endif

