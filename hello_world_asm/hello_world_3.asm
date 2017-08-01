; Scrolls repeating hello world strings across the screen

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

; set the channel
    ld a, 2             ; upper screen (use 1 for lower)
    call 5633           ; open channel

; repeatedly print the string
loopx:                  ; loop vertically
loopy:                  ; loop horizontally
    call setxy
    call printstr
    call shortpause
    ; clear the first character (to clean up after earlier prints)
    ; but don't clear if at the end of the line
    ld hl, ypos
    ld a, (hl)
    cp 32-eostr+string  ; compare to 32 (width of the screen - string length)
    jr z, noerase       ; don't erase if zero
    call setxy          ; set the print position
    ld a, 32            ; code for SPACE
    rst 16              ; print
noerase:
    ; increment ypos
    ld hl, ypos         ; load ypos addr
    inc (hl)            ; increment ypos
    ld a, (hl)          ; load ypos value into a
    cp 33-eostr+string  ; compare 33 (width of the screen + 1 - string length)
    jr nz, loopy        ; not equal? loop
    ; reached the end of the screen
    ld (hl), 0          ; reset ypos
    ; increment xpos
    ld hl, xpos         ; load xpos addr
    inc (hl)            ; increment xpos
    ld a, (hl)          ; load xpos value into a
    cp 22               ; compare to the chat height of the screen
    jr nz, loopx

    call longpause

; program complete
    ret

;
; subroutines
;

;
; short pause
;
shortpause:
    ld b, 1             ; time to pause (1/50 sec)
shortpauseloop:
    halt                ; wait for interrupt
    djnz shortpauseloop ; repeat if b not 0
    ret

;
; long pause
;
longpause:
    ld b, 100           ; time to pause (50 per second)
longpauseloop:
    halt                ; wait for interrupt
    djnz longpauseloop  ; repeat if b not 0
    ret

;
; print the string
;
printstr:
    ld de, string       ; address of string
    ld bc, eostr-string ; length of string to print
    call 8252           ; print the string
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

;
; data
;

string:
    defb "Hello world"  ; string to print
eostr:

xpos:
  defb 0
ypos:
  defb 0
