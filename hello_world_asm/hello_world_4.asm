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

; define some constants
defc screenwidth  = 32  ; char width of the screen
defc screenheight = 22  ; char height of the screen

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


; scrolling text vertically loop
xloop:
    ; set ypos to 0
    ld a, 0
    ld (ypos), a
    ; set offset to zero
    ld (offset), a
    ; set counter to 1
    ld a, 1
    ld (counter), a

    ; increment xpos
    ld a, (xpos)
    inc a
    ld (xpos), a

    ; if xpos > screenheight, end of vertical scrolling
    ld a, (xpos)
    ld b, a
    ld a, screenheight
    cp b
    jr z, end


; scrolling text horizontally loop
yloop:
    ; if counter > screen width, string at right side of screen
    ld a, (counter)
    ld b, screenwidth+1
    cp b
    jr nc, strend

    ; if counter < string length, string is at left side of screen
    ld a, (counter)       ; loop position stored in counter
    ld b, eostr-string+1  ; length of string
    cp b
    jr c, strstart
    ; if counter >= string length < screen width. string in middle of screen
    jr nc, strmiddle      ; string fully on screen
    jr main

strstart:                 ; string is partially on screen, add new char
    ld e, a
    jr main

strmiddle:              ; string is fully on screen, scroll to right
    ; clear the current char at pos
    call setxy
    ld a, 32            ; code for SPACE
    rst 16              ; print SPACE
    ; increment ypos
    ld a, (ypos)
    inc a
    ld (ypos), a
    ; set e to length of string
    ld e, eostr-string
    jr main

strend:                 ; string is at end of screen, remove one char
    ; clear the current char at pos
    call setxy
    ld a, 32            ; code for SPACE
    rst 16              ; print SPACE
    ; increment ypos
    ld a, (ypos)
    inc a
    ld (ypos), a
    ; set e to length of string - (counter - screenwidth)
    ld a, (counter)
    ld e, a
    ld a, eostr - string + screenwidth
    sub a, e
    ld e, a
    jr main

main:
    ; if ypos > screenwidth, end of horizontal scrolling
    ld a, (ypos)
    ld b, a
    ld a, screenwidth
    cp b
    jr z, xloop

    call setxy
    ; calculate start pos of string to print
    ld hl, eostr
    ld d, 0
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

    jr yloop

end:
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
    ld b, 2             ; time to pause (1/50 sec)
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
  defb -1
ypos:
  defb 0
offset:
  defb 0, 0
counter:
  defb 1
