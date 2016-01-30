/* Example of passing a function as an argument (in this case, to da_for_all) */
/* This program should print the integers from 1 to 10 on the screen. */

#include <stdio.h>
#include "libdarray.h"

void multiply_by_two(darray_element_t item)
{
  *(float*)item *= 2;
}

void print_item(darray_element_t item)
{
  printf("%f ", *(float*)item);
}

int main()
{
  darray_t a;
  float *f;
  int i;

  /* Create and initialize a dynamic array */
  a = da_init();

  /* Insert ten numbers - zero to five in 0.5 jumps - into the array */
  for (i = 1; i <= 10; i++)
  {
    f = (float*)malloc(sizeof(float));
    *f = i / 2.0;
    da_add(a, f);
  }

  /* Multiply all the numbers in the array by two */
  da_for_all(a, multiply_by_two);

  /* Print the entire array on the screen (should print 1 to 10) */
  da_for_all(a, print_item);
  printf("\n");

  /* destroy the array */
  da_dispose(a);

  /* The memory allocated with 'malloc' will be freed when program exits. */
  
  return 0;
}
