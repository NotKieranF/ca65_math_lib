; Sine and cosine routines
; Takes unsigned 8-bit angle in A
; Returns signed 8-bit offset in A
; Trashes Y, $00
.GLOBAL sin, cos
; #end-header



; Locals
sign		:= $00



.CODE
cos:
	; Phase shift by 90 degrees for cosine, then fall through to sine routine
	CLC
	ADC #$40

sin:
	; If input angle is in the 3rd or 4th quadrants, then we flip the result of our lookup
	LDY #$00
	CMP #$80
	BCC @no_vert_flip
@vert_flip:
	DEY							; Y = $FF
	AND #%01111111				; Ensure index is within 1st or 2nd quadrant
@no_vert_flip:
	STY sign

	; If the input angle is in the 2nd or 4th quadrants, then we flip our index into the lookup table
	CMP #$40
	BCC @no_horiz_flip
@horiz_flip:
	EOR #%01111111				; Flip index and ensure it's within the 1st quadrant
@no_horiz_flip:

	TAY
	LDA reduced_sin_table, Y
	EOR sign					; Flip result if needed

	RTS



.RODATA
; As a sine wave is symmetric about both the horizontal and vertical axis, only a quarter of the waveform needs to be stored
reduced_sin_table:
.BYTE	$00, $03, $06, $09, $0C, $0F, $12, $15, $18, $1C, $1F, $22, $25, $28, $2B, $2E
.BYTE	$30, $33, $36, $39, $3C, $3F, $41, $44, $47, $49, $4C, $4E, $51, $53, $55, $58
.BYTE	$5A, $5C, $5E, $60, $62, $64, $66, $68, $6A, $6C, $6D, $6F, $70, $72, $73, $75
.BYTE	$76, $77, $78, $79, $7A, $7B, $7C, $7C, $7D, $7E, $7E, $7F, $7F, $7F, $7F, $7F