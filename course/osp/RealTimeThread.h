// Operating Systems Project, Hadassah College, 2000
// Soft Real-Time Thread information class

#ifndef REALTIMETHREAD_H_
#define REALTIMETHREAD_H_

#include "Thread.h"
#include "Time.h"


class RealTimeThread : public Thread
{
public:

  // constructor. once a deadline is set, it cannot be changed
  RealTimeThread(void func(void*), Time deadline);

  // destructor
  void ~RealTimeThread();
  
  // get deadline
  Time get_deadline();
  
  // number of seconds from now until the deadline
  double get_deadline_distance();
}


#endif

