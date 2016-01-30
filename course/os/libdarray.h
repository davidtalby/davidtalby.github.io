/* Operating Systems Course, Hadassah College, Spring 1999, Exercise 8. */
/* Dynamic array header file. */

#ifndef _DLIST_H_

/* Type type of element that the array contains. By default a pointer. */
#ifndef darray_element_t
#define darray_element_t void *
#endif

/* declare 'struct darray_t { ... } darray_t' in libdarray.c to define
   what this structure actually contains. */
typedef struct darray *darray_t;

/* create and return a new dynamic array. Returns NULL on failure. */
darray_t da_init();

/* Free all allocated space of an array.
   Precondition: array has been initialized. */
void da_dispose(darray_t array);

/* Add 'element' to the end of the array.
   Precondition: array has been initialized.
   Returns the index of the element in the array if it was added,
   or -1 if it wasn't added. */
int da_add(darray_t array, darray_element_t element);

/* Set element number 'index' in the array to contain 'element'.
   Precondition: array has been initialized, and index is between 0 and size-1. */
void da_set(darray_t array, int index, darray_element_t element);

/* Access an item from the list.
   Precondition: array has been initialized, and index is between 0 and size-1. */
darray_element_t da_get(darray_t array, int index);

/* Remove element number 'index' from the array.
   This function may change indices of elements after 'index'.
   Precondition: array has been initialized, and index is between 0 and size-1. */
void da_remove(darray_t array, int index);

/* Quick-Sort the array using a given comparator function.
   compar(a,b) should return 1 if a>b, -1 if b>a, and 0 if a=b.
   Precondition: array has been initialized. */
void da_qsort(darray_t array,
        int (*compar)(const darray_element_t, const darray_element_t));

/* Activate a function over all elements of the list.
   Precondition: array has been initialized. */
void da_for_all(darray_t array, void (*action)(darray_element_t));

/* Return the number of elements in the list.
   Precondition: array has been initialized. */
int da_size(darray_t array);

/* Return 1 if the array is empty (size=0), and 0 otherwise.
   Precondition: array has been initialized. */
int da_is_empty(darray_t array);

#endif
