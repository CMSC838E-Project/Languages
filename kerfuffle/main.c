#include <stdio.h>
#include <stdlib.h>
#include "values.h"
#include "print.h"
#include "runtime.h"
#include "errors.h"

FILE* in;
FILE* out;
void (*error_handler)();
void (*type_error_handler)();
val_t *heap;

void error_exit()
{
  printf("err\n");
  exit(1);
}

void raise_error()
{
  return error_handler();
}

int main(int argc, char** argv)
{
  in = stdin;
  out = stdout;
  error_handler = &error_exit;
  type_error_handler = &default_type_handler;
  heap = malloc(8 * heap_size);

  val_t result;

  result = entry(heap);

  print_result(result);
  if (val_typeof(result) != T_VOID)
    putchar('\n');

  free(heap);
  return 0;
}
