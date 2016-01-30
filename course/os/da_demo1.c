/* Example of passing a function as an argument (in this case, to da_for_all) */

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

  a = da_init();

  /* Insert 200 numbers into the array a */
  for (i = 1; i <= 10; i++)
  {
    f = (float*)malloc(sizeof(float));
    *f = i / 2.0;
    da_add(a, f);
  }

  /* Multiply all the numbers by two */
  da_for_all(a, multiply_by_two);

  /* Print the adjusted list on the screen (should print 1 to 10) */
  da_for_all(a, print_item);
  printf("\n");

  da_dispose(a);
  return 0;
}
