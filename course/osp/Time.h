// Operating Systems Project, Hadassah College, 2000
// Time class

#ifndef HTIME_H_
#define HTIME_H_


class Time
{
public:

  // conststror. build object to represent specific time
  Time(int day, int month, int year, int hour, int minute, double seconds);

  // default constructor. build object to represent now
  Time();
  
  // destructor
  ~Time();

  // direct read/write access to time
  int day, month, year, hour, minute;
  double seconds;
    
  // add or substract a given number of seconds
  Time operator +(double seconds);
  Time operator -(double seconds);
  
  // find the number of seconds between two points in time
  double operator -(Time other);
}


#endif

