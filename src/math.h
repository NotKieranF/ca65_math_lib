.IFNDEF MATH_H
MATH_H	= 1

; Absolute value routine
; Takes signed 8-bit input in A
; Returns unsigned 8-bit magnitude in A
; Trashes no registers or memory
.IMPORT	abs

; Atan2 routine
; Takes signed 8-bit x-offset in A, signed 8-bit y-offset in Y
; Returns unsigned 8-bit angle in A
; Trashes Y, $00, $01, $02
.IMPORT atan2

; Precomputed identity table
.IMPORT identity_table

; Unsigned shift and add multiplication routine
; Takes unsigned 8-bit multiplier in A, and unsigned 8-bit multiplicand in Y
; Returns hi 8-bits of product in A, and lo 8-bits of product in Y
; Trashes $00, $01
.IMPORT mult

; Sine and cosine routines
; Takes unsigned 8-bit angle in A
; Returns signed 8-bit offset in A
; Trashes Y, $00
.IMPORT sin, cos

; Precomputed square lookup tables
.IMPORT square_table_lo, square_table_hi

.ENDIF