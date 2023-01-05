; Unsigned shift and subtract division routine
; Takes unsigned 8-bit divisor in A, hi 8-bits of unsigned dividend in Y, and lo 8-bits of unsigned dividend in X
; Returns 8-bit remainder in A, hi 8-bits of unsigned quotient in Y, and lo 8-bits of unsigned quotient in X
; Trashes $00, $01, $02
.GLOBAL div
; #end-header



; Locals
divisor			:= $00
dividend_lo		:= $01
dividend_hi		:= $02


div:
	STA divisor
	STX dividend_lo
	STY dividend_hi

	LDY #$10				; Initialize Y for the number of bits to shift through
	LDA #$00
	CLC
@loop:
	ROL dividend_lo
	ROL dividend_hi
	ROL
	CMP divisor
	BCC :+					; If the divisor goes into A, then we want to subtract the divisor and set the carry bit to be shifted into the quotient in this place, just as with long division
	SBC divisor				; C = 1. Fortunately, the carry flag is appropriately set by the compare/subtract, so no extra work is needed
:	DEY
	BNE @loop				; When coming out of the loop, the remainder is left in A

	ROL dividend_lo			; An extra rotate is needed to get the last bit of relevant data out of the carry flag
	ROL dividend_hi

	LDX dividend_lo
	LDY dividend_hi

	RTS