/*
 * Hello world 4 - embedded assembler in C
 *
 * For a complete list of the Spectrum's character set, check out:
 * https://en.wikipedia.org/wiki/ZX_Spectrum_character_set
 */

main()
{
  #asm

    ld a, 2
    call 5633

    ld de, string
    ld bc, string_eof - string
    call 8252

    string:
      defb $10, $03 ; ink colour
      defb $11, $04 ; paper colour
      defb "Hello world"
    string_eof:
      defb $00

  #endasm
}
