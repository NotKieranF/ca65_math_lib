; Atan2 routine, relies on the fact that atan2(y, x) = atan2(y/2, x/2) to maintain precision with inputs of varying magnitudes
; Takes signed 8-bit x-offset in A, signed 8-bit y-offset in Y
; Returns unsigned 8-bit angle in A
; Trashes Y, $00, $01, $02
.EXPORT atan2



; Locals
quadrant		:= $00
x_arg			:= $01
y_arg			:= $02

; Constants
SIGFIG_MASK		= %11111000
QUADRANT_MASK	= %00000011


.CODE
atan2:
	; Take the absolute value of the x argument, and record the sign bit to determine the quadrant
	ASL
	BCC @x_positive
@x_negative:
	EOR #$FF
	ADC #$00		; C = 1
	SEC				; Ensure correct sign bit is shifted into quadrant variable
@x_positive:
	ROL quadrant
	LSR
	STA x_arg

	; Take the absolute value of the y argument, and record the sign bit to determine the quadrant
	TAY
	ASL
	BCC @y_positive
@y_negative:
	EOR #$FF
	ADC #$00		; C = 1
	SEC				; Ensure correct sign bit is shifted into quadrant variable
@y_positive:
	ROL quadrant
	LSR
	STA y_arg

	; Shift both arguments right until they only have 3 significant figures
	LDA #SIGFIG_MASK
loop:
	BIT x_arg
	BNE :+
	BIT y_arg
	BEQ exit

:	LSR x_arg
	LSR y_arg
	JMP loop

exit:
	; Hi order bits of quadrant are unknown, so must be masked off
	LDA quadrant
	AND #QUADRANT_MASK
	STA quadrant

	; Combine both arguments into a single index into a precomputed table
	LDA y_arg
	ASL
	ASL
	ASL
	ORA x_arg
	TAY
	LDA reduced_atan_table, Y

	; Invert result and add offset as quadrant requires
	LDY quadrant
	EOR quadrant_inversion_table, Y
	CLC
	ADC quadrant_offset_table, Y

	RTS



.RODATA
; Precomputed atan values for the 1st quadrant
reduced_atan_table:
.BYTE	$00, $00, $00, $00, $00, $00, $00, $00
.BYTE	$40, $20, $13, $0D, $0A, $08, $07, $06
.BYTE	$40, $2D, $20, $18, $13, $10, $0D, $0B
.BYTE	$40, $33, $28, $20, $1A, $16, $13, $10
.BYTE	$40, $36, $2D, $26, $20, $1B, $18, $15
.BYTE	$40, $38, $30, $2A, $25, $20, $1C, $19
.BYTE	$40, $39, $33, $2D, $28, $24, $20, $1D
.BYTE	$40, $3A, $35, $30, $2A, $27, $23, $20

; The minimum angles in each quadrant
quadrant_offset_table:
.BYTE	$00, $C0, $40, $80

; The 2nd and 4th quadrants are inverted with respect to the 1st quadrant
quadrant_inversion_table:
.BYTE	$00, $3F, $3F, $00