; Simple hello world

; to compile with z88dk to a tap file, use
; z80asm +zx hello_world.asm
; make sure you're using a recent version of z88dk - tested with nightly build
; which can be downloaded from http://nightly.z88dk.org/

; to run this program using Spin, assemble, push into memory @ location 50000
; and then run the following basic

; 10 randomize usr 50000

    ld a, 2                     ; upper screen (use 1 for lower)
    call 5633                   ; open channel

    ld de, string           ; address of string
    ld bc, eostr-string         ; length of string to print
    call 8252                   ; print the string
    ret

string:
    defb "Hello world"   ; string to print
eostr:
