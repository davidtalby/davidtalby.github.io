// Operating Systems Project, Hadassah College, 2000
// Real-Time scheduler class

#ifndef REALTIMESCHEDULER_H_
#define REALTIMESCHEDULER_H_

#include "Scheduler.h"


class RealTimeScheduler : public Scheduler
{
public:

  // constructor
  // Real-Time threads will be scheduled first by Earliest Deadline First
  // Other threads will be scheduled by some untimed_scheduler
  RealTimeScheduler(Scheduler *untimed_scheduler);
  
  // destructor
  ~RealTimeScheduler();
}


#endif

