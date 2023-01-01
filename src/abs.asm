; Absolute value routine
; Takes signed 8-bit input in A
; Returns unsigned 8-bit magnitude in A
; Trashes no registers or memory
.EXPORT abs



.CODE
abs:
	CMP #$80		; If input is positive then return
	BCC @exit
	EOR #$FF		; Otherwise take two's compliment and return
	ADC #$00
@exit:
	RTS