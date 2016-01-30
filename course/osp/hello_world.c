#include "Scheduler.h"

Semaphore *s_hello;

int main()
{
  scheduler = new RoundRobinScheduler();

  s_hello = new Semaphore(0);

  scheduler->start(new Thread(hello, NULL));
  scheduler->start(new Thread(world, NULL));
  // three threads are active now!

  scheduler->running->wait_all();

  delete scheduler;   // optional
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
}

