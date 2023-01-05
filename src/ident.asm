; Precomputed identity table
; Can be useful for performing inter-register operations, e.g. ADC identity_table, X adds A and X together
.GLOBAL identity_table
; #end-header



.RODATA
identity_table:
.REPEAT	256, I
	.BYTE	I
.ENDREP