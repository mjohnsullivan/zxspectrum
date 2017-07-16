/*
 * Hello world 3 - defining custom print functions using control codes
 *
 * Adapted from https://www.z88dk.org/wiki/doku.php?id=examples:snippets:world
 *
 * See https://www.z88dk.org/forum/viewtopic.php?id=9563 for much more on
 * control codes in z88dk
 *
 * For a complete list of the Spectrum's character set, check out:
 * https://en.wikipedia.org/wiki/ZX_Spectrum_character_set
 */

#include <stdio.h>

#define printMode(mode)         printf("\x01%c", (mode))
#define clearScreen()           printf("\x0C")
#define setInkColour(colour)    printf("\x10%c", (colour))
#define setPaperColour(colour)  printf("\x11%c", (colour))
#define setFlashOn()            printf("\x12\x01")
#define setFlashOff()           printf("\x12\x00")
#define setPosition(x, y)       printf("\x16%c%c", (x) + 0x20, (y) + 0x20)

main()
{
  printMode(32);
  clearScreen();
  setInkColour(3);
  setPaperColour(4);
  setPosition(12, 12);
  setFlashOn();
  printf("Hello");
  setFlashOff();
  printf(" world!");
}
