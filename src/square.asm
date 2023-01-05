; Precomputed square lookup tables
.GLOBAL square_table_lo, square_table_hi
; #end-header



.RODATA
square_table_lo:
.REPEAT	256, I
	.BYTE	<(I * I)
.ENDREP

square_table_hi:
.REPEAT	256, I
	.BYTE	>(I * I)
.ENDREP