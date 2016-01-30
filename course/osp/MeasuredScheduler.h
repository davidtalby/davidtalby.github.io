// Operating Systems Project, Hadassah College, 2000
// Measured scheduler class

#ifndef MEASUREDSCHEDULER_H_
#define MEASUREDSCHEDULER_H_

#include "Scheduler.h"


class MeasuredScheduler : public Scheduler
{
public:

  // constructor. This class only takes statistics
  // actual scheduling work is done by the 'actual_scheduler'
  MeasuredScheduler(Scheduler *actual_scheduler);
  
  // destructor
  ~MeasuredScheduler();
  
  // total number of threads (including finished ones) in system
  int total_threads_count();
  
  // throughput = number of threads / total system runtime
  // should be called right after all threads finished to be useful
  double throughput();
  
  // reset the number of historical threads and clock to zero
  void reset();
}


#endif

