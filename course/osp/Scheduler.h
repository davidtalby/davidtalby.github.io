// Operating Systems Project, Hadassah College, 2000
// Abstract thread scheduler class

#ifndef SCHEDULER_H_
#define SCHEDULER_H_

#include "Semaphore.h"
#include "Thread.h"


class Scheduler
{
public:

  // The constructor create one thread object, called "first thread"
  // This thread runs the code after the constructor
  // on completion, the first thread exits the entire process

  // create a new thread that will run 'func' to completion
  // on completion, a thread created with start lets other threads run
  // returns a pointer to the new thread or null on error
  virtual Thread *start(Thread *t) = 0;

  // the currently running thread
  virtual Thread *running() = 0;

  // destructor - destroys all threads except the first thread
  // the first thread continues running afterwards
  virtual ~Scheduler();
}

// There must be only one scheduler object in a program
// This variable must point to it
// WARNING: The library uses SIGALRM, do not use it for any other purpose
extern Scheduler *scheduler;


#endif

