; Unsigned shift and add multiplication routine
; Takes unsigned 8-bit multiplier in A, and unsigned 8-bit multiplicand in Y
; Returns hi 8-bits of product in A, and lo 8-bits of product in Y
; Trashes $00, $01
.GLOBAL mult
; #end-header



; Locals
product_lo			:= $00
multiplicand		:= $01



.CODE
mult:
	EOR #$FF				; Invert the multiplier to save cycles in the shift and add loop
	STA product_lo
	STY multiplicand
	LDY #$08				; Initialize Y for the number of bits to loop through
	LDA #$00				; Initialize A for the shift and add loop

@loop:
	ROR product_lo			; C is unknown on the first iteration, but it gets shifted out at the end so it doesn't matter
	BCS @no_add
@add:
	ADC multiplicand		; C = 0
@no_add:
	LSR
	DEY
	BNE @loop

	ROR product_lo

	LDY product_lo
	RTS