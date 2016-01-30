// Operating Systems Project, Hadassah College, 2000
// General Semaphore class

#ifndef SEMAPHORE_H_
#define SEMAPHORE_H_


class Semaphore
{
public:

  // constructor and destructor
  Semaphore(int initial_value};
  virtual ~Semaphore();
  
  // atomically: wait until s > 0, then s--
  void wait();
  
  // atomically: s++
  void signal();
}


#endif

