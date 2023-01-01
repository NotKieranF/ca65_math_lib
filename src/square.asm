; Precomputed square lookup tables
.EXPORT square_table_lo, square_table_hi



.RODATA
square_table_lo:
.REPEAT	256, I
	.BYTE	<(I * I)
.ENDREP

square_table_hi:
.REPEAT	256, I
	.BYTE	>(I * I)
.ENDREP