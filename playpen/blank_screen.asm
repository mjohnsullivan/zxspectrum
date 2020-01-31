; to compile with Pasmo to tap:
; pasmo -1 --tapbas blank_screen.asm blank_screen.tap >> debug.txt

; to compile with z80asm to tap:
; z80asm +zx blank_screen.asm

; This is where your program starts in RAM.
    org 40000

; Clear the screen to black.
;   ld a,71         ; INK (0-7) + PAPER (0-7 * 8) + BRIGHT (0/64)
    ld a,110        ; Yellow ink (6), cyan paper (5 * 8), bright (64).
    ld (23693),a    ; Set our screen (permanent) colours.
;   xor a           ; Load accumulator with zero.
    ld a,5          ; Set the colour to cyan (5).
    call 8859       ; Set permanent border colours.
    call 3503       ; Clear the screen, open channel 2.
    ret             ; necessary for z80asm

; Pasmo needs this to know where to start running your program from.
; It should be the same as the address you specified at the top!
    end 40000       ; comment this out for z80asm


; Spectrum colour codes:
; 0 = Black
; 1 = Blue
; 2 = Red
; 3 = Magenta
; 4 = Green
; 5 = Cyan
; 6 = Yellow
; 7 = White
