// Operating Systems Project, Hadassah College, 2000
// Round-robin scheduler class

#ifndef ROUNDROBINSCHEDULER_H_
#define ROUNDROBINSCHEDULER_H_

#include "Scheduler.h"


class RoundRobinScheduler : public Scheduler
{
public:

  // constructor
  RoundRobinScheduler(double time_slice);
  
  // default constructor, sets time_slice to one second
  RoundRobinScheduler();

  // change the time slice. only takes effect from next preemption
  void set_time_slice(double new_slice);
  
  // current time slice
  double get_time_slice();
}


#endif

