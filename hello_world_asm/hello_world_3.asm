; WIP - not completed yet
; Will eventually scroll hello world across and down the screen

; to compile with z88dk to a tap file, use
; z80asm +zx hello_world_3.asm
; make sure you're using a recent version of z88dk - tested with nightly build
; which can be downloaded from http://nightly.z88dk.org/

; Alternate build method:
; z80asm -b -o=program.bin -r=33000 hello_world_3.asm
; appmake +zx -b program.bin --org 33000

; to run this program using Spin, assemble, push into memory @ location 33000
; and then run the following basic
; 10 randomize usr 33000

; Set the screen and ink colour
    ld a, 49            ; blue ink (1) on yellow paper (6*8)
    ld (23693), a       ; set the screen colours
    call 3503           ; clear the screen

; set the border colour
    ld a, 2             ; red (2)
    out (254), a        ; write to port 254 - least significant bytes set color

    ld a, 2             ; upper screen (use 1 for lower)
    call 5633           ; open channel

    ld de, string       ; address of string
    ld bc, eostr-string ; length of string to print
    call 8252           ; print the string

; pause for 2 seconds
    ld b, 100           ; time to pause (50 per second)
delay:
    halt                ; wait for an interrupt
    djnz delay          ; repeat

    ret

string:
    defb "Hello world"  ; string to print
eostr:
