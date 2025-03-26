; Define commonly used, long names
	%define	GPUCOM		GPU_Command
	%define	GPUTEX		GPU_SelectedTexture
	%define	GPUREG		GPU_SelectedRegion
	%define	DRAWREG		GPUCommand_DrawRegion
	%define DRAWX		GPU_DrawingPointX
	%define DRAWY		GPU_DrawingPointY

	; Jump to the end of this file
	; for include to work at top
	jmp _dbend
; Prints a hex number
; to the screen with
; parameters; value, x, y
; pushed in that order
_debug:
_debugnum:	

_dbsavestack:
	; Create local stack
	push BP
	mov  BP,		SP
	; Save our registers, texture, and region
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	push R7
	push R8
	push R9
	push R10
	push R11
	push R12
	push R13
	in   R0,	GPUTEX
	push R0
	out  GPUTEX,	-1
	in   R0,	GPUREG
	push R0
_dbargs:	
	mov  R0,	[BP+4]		 ; Retrieve value
	mov  R5,	[BP+3]		 ; Retrieve xpos
	mov  R6,	[BP+2]	     ; Retrieve ypos
	out  DRAWY,  R6          ; Set draw y
	mov  R3,	  0x08       ; Set counter
	mov  R7,	  0xF0000000 ; Set mask
	mov  R8,      -28        ; Set shift
_db0x:
	out  GPUREG, 0x30
	out  DRAWX,  R5
	out  GPUCOM, DRAWREG
	iadd R5,     0x0A
	out  GPUREG, 0x78
	out  DRAWX,  R5
	out  GPUCOM, DRAWREG
	iadd R5,     0x0A
_dbitoa:
	mov  R1,		R0	  ; make copy of R1
	and  R1,	    R7	  ; retrieve hextet
	shl  R1,		R8
	mov  R4,		R1	  ; get copy of last R1
	igt  R4,	  0x09	  ; check if value is A-F
	jf	 R4, _dbinneritoa ; skip A-F add logic
	iadd R1,	  0x07	  ; add 7 to the value
_dbinneritoa:
	iadd R1,	  0x30	; convert to ascii
	out  GPUREG,  R1
	out  DRAWX,   R5
	out  GPUCOM,  DRAWREG
	iadd R5,      0x0A  ; move xpos right 
	shl  R7,	    -4	; shift mask right
	iadd R8,      0x04  ; decrease shift amount
	isub R3,	  0x01	; decrement the counter
	mov  R4,		R3
	ieq  R4,	  0x00	; check if done	;
	jf   R4,	 _dbitoa;				;
_dbrestore:
	; Restore registers, texture, and region
	mov  [BP+4],		 R5 ; Move updated xpos to BP+4
	mov  R1,		 [BP+1] ; Move ret addr to R1
	mov  [BP+3],		 R1 ; Move R1 to BP+3

	pop	 R1
	out  GPUREG,		 R1
	pop	 R1
	out  GPUTEX,		 R1
	pop  R13
	pop  R12
	pop  R11
	pop  R10
	pop  R9
	pop  R8
	pop  R7
	pop  R6
	pop  R5
	pop  R4
	pop  R3
	pop  R2
	pop  R1
	pop  R0
	; Restore stack
	mov  SP,			 BP
	pop  BP
	iadd SP,			  2
	ret

; Memory debugger: takes
; arguments *startaddr and
; *endaddr pushed in that
; order

_debugmem:
_dbmsavestack:
	; Create local stack
	push BP
	mov  BP,		SP
	; Save our registers, texture, and region
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	push R7
	push R8
	push R9
	push R10
	push R11
	push R12
	push R13
	in   R0,	GPUTEX
	push R0
	out  GPUTEX,	-1
	in   R0,	GPUREG
	push R0

	mov  R0,	[BP+3] 	; Starting memory address
	mov  R1,	[BP+2] 	; Ending memory address
	mov  R2,	  0x00 	; Initial x value
	mov  R3,	  0x00 	; Initial y value
_dbmstartloop:
	; Print open bracket
	mov  R4,	  0x5B  ; Move '[' to R4
	out  DRAWX,		R2   ; Update xpos
	out  DRAWY,		R3
	out  GPUREG,	R4   ; Send '[' to GPU
	out  GPUCOM, DRAWREG ; Draw '['
	iadd R2,	  0x0A   ; Update xpos

	; Print memory address
	push R0				; Push value
	push R2				; Push xpos
	push R3				; Push ypos
	call _debug
	pop  R2				; update xpos

	; Print ']: '
	mov  R4,	  0x5D   ; Move ']' into R4
	out  DRAWX,		R2   ; Update xpos
	out  GPUREG,	R4   ; Send ']' to GPU
	out  GPUCOM, DRAWREG ; Draw ']'
	iadd R2,	  0x0A   ; Update xpos
	mov  R4,	  0x3A   ; Move ':' into R4
	out  DRAWX,		R2   ; Update xpos
	out  GPUREG,	R4   ; Send ':' to GPU
	out  GPUCOM, DRAWREG ; Draw ':'
	iadd R2,	  0x0A   ; Update xpos

	; Print contents of memory addr
	mov  R4,	  [R0]
	push R4				; Push value from RAM
	push R2				; Push xpos
	push R3				; Push ypos
	call _debug
	pop  R2				; Update xpos
	
	;Set up for next memory address
	iadd R3,	  0x14	; Adjust ypos
	mov  R2,	  0x00  ; Adjust xpos
	iadd R0,	  0x01  ; Move to next mem addr
	mov  R4,		R0  ; Copy it into R4
	igt  R4,		R1
	jf   R4, _dbmstartloop
_dbmrestore:
	; Restore registers, texture, and region
	;mov  R1,		 [BP+1]
	;mov  [BP+3],		 R1

	pop	 R1
	out  GPUREG,		 R1
	pop	 R1
	out  GPUTEX,		 R1
	pop  R13
	pop  R12
	pop  R11
	pop  R10
	pop  R9
	pop  R8
	pop  R7
	pop  R6
	pop  R5
	pop  R4
	pop  R3
	pop  R2
	pop  R1
	pop  R0
	; Restore stack
	;iadd SP,			  2
	;mov  SP,			 BP
	;pop  BP
	mov	 SP, BP
	pop  BP
	ret


	
_debugregs:
_dbrsavestack:
	; Create local stack
	push BP
	mov  BP,		SP
	; Save our registers, texture, and region
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	push R7
	push R8
	push R9
	push R10
	push R11
	push R12
	push R13
	in   R0,	GPUTEX
	push R0
	out  GPUTEX,	-1
	in   R0,	GPUREG
	push R0

	mov  R0,	  0x00 ; initialize xpos
	mov  R1,	  0x00 ; initialize ypos
	mov  R2,      0x00 ; initialize counter
	lea  R3,	[BP-1] ; get first memory addr
	mov  R6,	  0x00 ; hacky xcoord fixer
_dbrloop:
	; Print "R"
	iadd R0,		R6   ; set proper x
	mov  R4,	  0x52  ; Move 'R' to R4
	out  DRAWX,		R0   ; Update xpos
	out  DRAWY,		R1
	out  GPUREG,	R4   ; Send 'R' to GPU
	out  GPUCOM, DRAWREG ; Draw 'R'
	iadd R0,	  0x0A   ; Update xpos
	; Print the register number
	mov  R4,		R2
	mov  R5,		R4
	igt  R5,		 9
	jf   R5, _dbrprintreg
	out  DRAWX,		R0   ; Update xpos
	out  DRAWY,		R1
	out  GPUREG,  0x31   ; Send '1' to GPU
	out  GPUCOM, DRAWREG ; Draw '1'
	iadd R0,	  0x0A   ; Update xpos
	isub R4,	  0x0A   ; Get second digit

_dbrprintreg:
	iadd R4,	  0x30
	out  DRAWX,		R0   ; Update xpos
	out  DRAWY,		R1
	out  GPUREG,	R4   ; Send number to GPU
	out  GPUCOM, DRAWREG ; Draw number
	iadd R0,	  0x0A   ; Update xpos
	; Print ":"
	mov  R4,	  0x3A   ; Move ':' to R4
	out  DRAWX,		R0   ; Update xpos
	out  DRAWY,		R1
	out  GPUREG,	R4   ; Send ':' to GPU
	out  GPUCOM, DRAWREG ; Draw ':'
	iadd R0,	  0x0A   ; Update xpos
	; Print value in register
	mov  R4,	  [R3]   ; get the register's value
	push R4				 ; push value
	push R0				 ; push xpos
	push R1				 ; push ypos
	call _debug
	pop  R0				 ; get updated x
	mov  R0,	  0x00   ; reset x
	iadd R1,	  0x14   ; update y
	iadd R2,	  0x01   ; update counter
	isub R3,	  0x01   ; update mem addr
	
	mov  R5,		R2
	igt  R5,	    13
	jt   R5, _dbrrestore
	mov  R5,		R1
	ige  R5,	  0x8C
	jf   R5,  _dbrloop
	mov  R1,	  0x00
	mov  R6,	  0xAA
	jmp  _dbrloop
	
_dbrrestore:
	; Restore registers, texture, and region
	;mov  R1,		 [BP+1]
	;mov  [BP+3],		 R1
	;hlt

	pop	 R1
	out  GPUREG,		 R1
	pop	 R1
	out  GPUTEX,		 R1
	pop  R13
	pop  R12
	pop  R11
	pop  R10
	pop  R9
	pop  R8
	pop  R7
	pop  R6
	pop  R5
	pop  R4
	pop  R3
	pop  R2
	pop  R1
	pop  R0
	; Restore stack
	;iadd SP,			  2
	;mov  SP,			 BP
	;pop  BP
	mov	 SP, BP
	pop  BP
	ret

_dbend:
