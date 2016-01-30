#include "Scheduler.h"

Semaphore *s_hello, *s_world;

int main()
{
  scheduler = new MeasuredScheduler(new RealTimeScheduler(new PriorityScheduler()));

  s_hello = scheduler->new_semaphore(0);
  s_world = scheduler->new_semaphore(0);

  scheduler->start(new MeasuredThread(new RealTimeThread(hello, new Time() + 5.0)));
  scheduler->start(new MeasuredThread(new PriorityThread(world, 0.1)));
  // three threads are active now!

  s_world->wait();
  printf("The throughput was %d\n", ((MeasuredScheduler*)scheduler)->throughput());
  delete scheduler;
}

void hello()
{
  printf("Hello, ");
  s_hello->signal();
}

void world()
{
  s_hello->wait();
  printf("World!\n");
  s_world->signal();
}

