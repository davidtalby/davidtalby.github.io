/* This demo program first changes libdarray.h to be a list of integers,
   using the processor (#define darray_element_t int). Then, it inserts
   200 times the number 789 into the list, and afterwards reads the 200'th
   number in the list and prints it on the screen.
   Try to change da_get(a, 199) to da_get(a, -2) to check the assert()
   mechanism. Do so with and without '#define NDEBUG' in your code.
*/

#include <stdio.h>

#define darray_element_t int
#include "libdarray.h"

int main()
{
  darray_t a;
  int i;

  a = da_init();
  for (i=0; i < 200; i++) da_add(a, 789);
  i = da_get(a, 199);
  printf("%d", i);
  da_dispose(a);
  return 0;
}

