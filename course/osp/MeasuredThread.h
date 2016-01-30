// Operating Systems Project, Hadassah College, 2000
// Measured Thread information class

#ifndef MEASUREDTHREAD_H_
#define MEASUREDTHREAD_H_

#include "Thread.h"


class MeasuredThread : public Thread
{
public:
  
  // constructor
  MeasuredThread(Thread *being_measured);

  // destructor
  void ~MeasuredThread();
  
  // number of bursts of execution the thread had
  int bursts_count();

  // average length in seconds of each burst  
  double average_burst_time();
  
  // total runtime in seconds
  double cumulative_runtime();
  
  // average time before a burst (including first one)
  double average_wait_time();

  // total wait time since thread was created
  double cumulative_wait_time();

  // time the thread was asleep because its sleep() function was called
  // this time is not part of its wait time or runtime
  double cumulative_sleep_time();

  // slowdown = (waittime + runtime) / runtime
  double slowdown();
}

