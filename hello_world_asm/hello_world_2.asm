; Simple hello world with control codes that repeated prints

; to compile with z88dk to a tap file, use
; z80asm +zx hello_world_2.asm

		; org 50000		    ; origin point of code in memory

		ld a, 2			    ; upper screen (use 1 for lower)
		call 5633		    ; open channel

loop:	ld de, string		; address of string
		ld bc, eostr-string ; length of string to print
		call 8252		    ; print the string
		jp loop			    ; repeat until screen is filled

string:	defb 16, 3 		    ; ink colour
		defb 17, 4		    ; paper colour
		defb "Hello world"	; string to print
		defb 13			    ; RETURN
eostr:
