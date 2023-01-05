; Absolute value routine
; Takes signed 8-bit input in A
; Returns unsigned 8-bit magnitude in A
; Trashes no registers or memory
; 9 bytes, 17 cycles best case, 20 cycles worst case
.GLOBAL abs
; #end-header



.CODE
abs:
	CMP #$80		; If input is positive then return
	BCC @exit
	EOR #$FF		; Otherwise take two's compliment and return
	ADC #$00
@exit:
	RTS