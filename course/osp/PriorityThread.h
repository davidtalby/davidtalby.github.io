// Operating Systems Project, Hadassah College, 2000
// Priority Thread information class

#ifndef PRIORITYTHREAD_H_
#define PRIORITYTHREAD_H_

#include "Thread.h"


class PriorityThread : public Thread
{
public:
  
  // Thread priority must be betwen 0.0 and 1.0
  // priority of threads that are not PriorityThread objects is 0.5
  
  // constructor
  PriorityThread(void func(void*), double priority);

  // destructor
  void ~PriorityThread();
  
  // change thread priority
  int set_priority(int new_priority);
  
  // current priority
  int get_priority();
}


#endif

