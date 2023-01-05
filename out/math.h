.IFNDEF MATH_H
MATH_H = 1
.SCOPE math

; Absolute value routine
; Takes signed 8-bit input in A
; Returns unsigned 8-bit magnitude in A
; Trashes no registers or memory
; 9 bytes, 17 cycles best case, 20 cycles worst case
.GLOBAL abs

; Atan2 routine, relies on the fact that atan2(y, x) = atan2(y/2, x/2) to maintain precision with inputs of varying magnitudes
; Takes signed 8-bit x-offset in A, signed 8-bit y-offset in Y
; Returns unsigned 8-bit angle in A
; Trashes Y, $00, $01, $02
.GLOBAL atan2

; Unsigned shift and subtract division routine
; Takes unsigned 8-bit divisor in A, hi 8-bits of unsigned dividend in Y, and lo 8-bits of unsigned dividend in X
; Returns 8-bit remainder in A, hi 8-bits of unsigned quotient in Y, and lo 8-bits of unsigned quotient in X
; Trashes $00, $01, $02
.GLOBAL div

; Precomputed identity table
; Can be useful for performing inter-register operations, e.g. ADC identity_table, X adds A and X together
.GLOBAL identity_table

; Unsigned shift and add multiplication routine
; Takes unsigned 8-bit multiplier in A, and unsigned 8-bit multiplicand in Y
; Returns hi 8-bits of product in A, and lo 8-bits of product in Y
; Trashes $00, $01
.GLOBAL mult

; Sine and cosine routines
; Takes unsigned 8-bit angle in A
; Returns signed 8-bit offset in A
; Trashes Y, $00
.GLOBAL sin, cos

; Precomputed square lookup tables
.GLOBAL square_table_lo, square_table_hi

.ENDSCOPE
.ENDIF