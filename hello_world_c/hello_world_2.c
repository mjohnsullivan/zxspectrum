/*
 * Hello world 2 - Using control codes
 *
 * Adapted from https://www.z88dk.org/wiki/doku.php?id=examples:snippets:world
 *
 * For a complete list of the Spectrum's character set, check out:
 * https://en.wikipedia.org/wiki/ZX_Spectrum_character_set
 */

#include <stdio.h>

main()
{
  printf("%c", 12); // Clear the screen - 'delete' keypress (hex 0x0C)
  // AT coordinates need to be offset by 0x20 (space character)
  printf("%c%c%c", 22, 12 + 0x20, 12 + 0x20); // Position text at (12, 12) (hex 0x16)
  printf("%c%c", 16, 3); // Set ink colour (hex 0x10)
  printf("%c%c", 17, 4); // Set paper colour (hex 0x11)
  printf("%c%c", 18, 1); // Flash on
  printf("Hello");
  printf("%c", 32); // Space
  printf("%c%c", 18, 0); // Flash off
  printf("world!\n");
}
