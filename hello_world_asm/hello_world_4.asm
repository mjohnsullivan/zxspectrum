; Scrolls  hello world across and down the screen

; to compile with z88dk to a tap file, use
; z80asm +zx hello_world_4.asm
; make sure you're using a recent version of z88dk - tested with nightly build
; which can be downloaded from http://nightly.z88dk.org/

; Alternate build method:
; z80asm -b -o=program.bin -r=33000 hello_world_4.asm
; appmake +zx -b program.bin --org 33000

; to run this program using Spin, assemble, push into memory @ location 33000
; and then run the following basic
; 10 randomize usr 33000

; define some common ROM routine locations
defc opench    = $1601  ; open channel (5633 decimal)
defc print     = $203C  ; print (8252 decimal)
defc clear     = $0DAF  ; clear (3503 decimal)
defc screencol = $5C8D  ; set ink and paper colors (23693 decimal)

; set the screen and ink colour
    ld a, 49            ; blue ink (1) on yellow paper (6*8)
    ld (screencol), a   ; set the screen colours
    call clear          ; clear the screen

; set the border colour
    ld a, 2             ; red (2)
    out (254), a        ; write to port 254 - least significant bytes set color

; set the channel
    ld a, 2             ; upper screen (use 1 for lower)
    call opench         ; open channel

; second tick
;    call setxy
;    ld a, 1
;    ld b, 2
;    ld de, eostr-2
;    ld bc, eostr-eostr+2
;    call print
;    call shortpause

; third tick
loop:
    ld d, 0
    ld a, (counter)

    ; if a < strlen, e=a && xpos=0
    ; if a >= strlen, e=strlen && xpos++
    ld b, eostr-string+1 ; length of string
    cp b
    jr c, strstart
    jr nc, strmiddle
    jr main

strstart:
    ld e, a
    jr main

strmiddle:
    ; clear the current char at pos
    call setxy
    ld a, 32            ; code for SPACE
    rst 16              ; print SPACE
    ; increment ypos
    ld a, (ypos)
    inc a
    ld (ypos), a
    ; set e to length od string
    ld e, eostr-string

main:
    call setxy
    ; calculate start pos of string to print
    ld hl, eostr
    sbc hl, de
    ld (offset), hl
    ld de, (offset)
    ; calculate end pos of string to print
    ld hl, eostr
    sbc hl, de
    ld (offset), hl
    ld bc, (offset)
    ; print the resulting substring
    call print
    call shortpause

    ; increment counter
    ld a, (counter)
    inc a
    ld (counter), a

    ; compare counter to 10
    ld b, 20
    ld a, (counter)
    cp b
    jr nz, loop
    ret

;
; set the x and y position for text writing
;
setxy:
    ld a, 22            ; control code for AT command
    rst 16              ; 'print' AT command
    ld a, (xpos)        ; load the x position
    rst 16              ; print
    ld a, (ypos)        ; load the y position
    rst 16              ; print
    ret                 ; position set, return

shortpause:
    ld b, 10            ; time to pause (1/50 sec)
shortpauseloop:
    halt                ; wait for interrupt
    djnz shortpauseloop ; repeat if b not 0
    ret


printstr:
    ld de, string       ; address of string
    ld bc, eostr-string ; length of string to print
    call print          ; print the string
    ret

string:
    defb "Hello world"  ; hello world string
eostr:                  ; end of string marker

xpos:
  defb 0
ypos:
  defb 0
offset:
  defb 0, 0
counter:
  defb 1
