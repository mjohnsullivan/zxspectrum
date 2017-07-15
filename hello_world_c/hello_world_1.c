/*
 * Hello world 1 - Simplest hello world example
 *
 * Adapted from https://www.z88dk.org/wiki/doku.php?id=examples:snippets:world
 *
 * For a complete list of the Spectrum's character set, check out:
 * https://en.wikipedia.org/wiki/ZX_Spectrum_character_set
 */

#include <stdio.h>

main()
{
  // 12 (hex 0x0C) clears the screen - equivalent to 'delete' keypress
  printf("%cHello world\n", 12);
}
