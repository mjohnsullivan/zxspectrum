/*
 * Hello world
 */

#include <stdio.h>

main()
{
  printf("%c", 12); // Clear the screen - 'delete' keypress (hex 0x0C)
  printf("%c%c", 16, 3); // Set ink colour (hex 0x10)
  printf("%c%c", 17, 4); // Set paper colour (hex 0x11)
  printf("%c%c", 18, 1); // Flash on
  printf("Hello");
  printf("%c", 32); // Space
  printf("%c%c", 18, 0); // Flash off
  printf("world!\n");
}
