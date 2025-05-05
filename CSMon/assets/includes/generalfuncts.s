%define	GPUTEX	GPU_SelectedTexture
%define	GPUREG	GPU_SelectedRegion
%define	GPUCOM	GPU_Command
%define	GPUX	GPU_DrawingPointX
%define	GPUY	GPU_DrawingPointY
%define	DRAW	GPUCommand_DrawRegion

;; General purpose subroutines
;; that may/will get frequent
;; use

jmp _gfend

; Base 10 ItoA
; Args: int Memaddr, int Value
; Converts number to string
_gfitoa:
_genitoa:
_itoasavestack:
	; Create local stack
	push BP
	mov  BP,        SP
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
	in   R0,		GPUTEX
	push R0
	out  GPUTEX,		-1
	in   R0,		GPUREG
	push R0
_itoaargs:
	mov  R1,	[BP+3] ; Mem addr
	mov  R0,	[BP+2] ; Value
	; Check if negative and fix
	mov  R13,	0		  ; set null terminator
	push R13
	mov	 R13,	R0
	ilt  R13,	0
	jf   R13,	_itoamain
	mov	 R2,	0x2D	  ; '-'
	mov  [R1],	R2		  ; put char in mem
	iadd R1,	1		  ; next mem addr
	isgn R0				  ; negate value
_itoamain:
	mov  R2,	R0
	imod R2,	10
	iadd R2,	0x30
	push R2
	idiv R0,	10
	mov	 R13,	R0
	ieq  R13,	0
	jf   R13,	_itoamain
_itoarev:
	pop  R0
	mov  [R1],	R0
	iadd R1,	1
	mov  R13,	R0
	ieq  R13,	0
	jf   R13,	_itoarev
_itoarestorestack:
	; Restore registers, texture, and region
	pop  R1
	out  GPUREG,	R1
	pop  R1
	out  GPUTEX,	R1
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
	mov  SP, BP
	pop  BP
	ret

; Base 10 FtoA
; Args: int Memaddr, int Value
; Converts number to string
_gfftoa:
_genftoa:
_ftoasavestack:
	; Create local stack
	push BP
	mov  BP,        SP
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
	in   R0,		GPUTEX
	push R0
	out  GPUTEX,		-1
	in   R0,		GPUREG
	push R0
_ftoaargs:
	mov  R1,	[BP+3] ; Mem addr
	mov  R0,	[BP+2] ; Value
	; Check if negative and fix
	mov  R13,	0		  ; set null terminator
	push R13
	mov	 R13,	R0
	ilt  R13,	0
	jf   R13,	_ftoaconvert
	mov	 R2,	0x2D	  ; '-'
	mov  [R1],	R2		  ; put char in mem
	iadd R1,	1		  ; next mem addr
	isgn R0				  ; negate value
_ftoaconvert:
	mov  R3,	R0		  ; make copy 
	cfi  R3				  ; get whole component
	imul R3,	100000	  ; shift left 4 spaces
	fmul R0,	100000	  ; get shifted whole+fraction
	cfi  R0				  ; cut leftover fraction
	isub R0,	R3		  ; cut whole component
	idiv R3,	100000	  ; adjust whole component back
	mov  R4,	5
_ftoafracmain:
	isub R4,	1
	mov  R2,	R0
	imod R2,	10
	iadd R2,	0x30
	push R2
	idiv R0,	10
	mov	 R13,	R4
	ieq  R13,	0
	jf   R13,	_ftoafracmain
	mov  R2,	0x2E	  ; "."
	push R2
_ftoawholemain:
	mov  R2,	R3
	imod R2,	10
	iadd R2,	0x30
	push R2
	idiv R3,	10
	mov	 R13,	R3
	ieq  R13,	0
	jf   R13,	_ftoawholemain
_ftoarev:
	pop  R0
	mov  [R1],	R0
	iadd R1,	1
	mov  R13,	R0
	ieq  R13,	0
	jf   R13,	_ftoarev
_ftoarestorestack:
	; Restore registers, texture, and region
	pop  R1
	out  GPUREG,	R1
	pop  R1
	out  GPUTEX,	R1
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
	mov  SP, BP
	pop  BP
	ret

; String Print At
; Args: int Memaddr, int X, int Y
; Prints \0 terminated string
; at specified location
_gfprint:
_genprint:
_printsavestack:
	; Create local stack
	push BP
	mov  BP,        SP
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
	in   R0,    GPUTEX
	push R0
	out  GPUTEX,    -1
	in   R0,    GPUREG
	push R0
	in   R0,    GPUY
	push R0
	in   R0,    GPUX
	push R0
_printargs:
	mov  R0,	[BP+4] ; Value
	mov  R1,	[BP+3] ; Xpos
	mov  R2,	[BP+2] ; Ypos
	out  GPUY, 	 R2
_gfprintmain:
	mov  R3,	[R0]
	mov  R4,	 R3
	ile  R4,	  0
	jt   R4,    _printrestorestack
;_LFCR:
;	mov  R4,	 R3			; Check for newlines
;	ieq  R4,	 10			;
;	jf   R4,	_notLFCR	;
;	iadd R2,	 20			; Move Y down
;	out  GPUY,	 R2			;
;	mov  R3,	 20			; Set region to valid blank
;_notLFCR:
	out  GPUREG, R3
	out  GPUX,	 R1
	out  GPUCOM, DRAW
	iadd R0,	  1
	iadd R1,	 10
	jmp  _gfprintmain
_printrestorestack:
	; Restore registers, texture, and region
	pop  R0
	out  GPUX,		R0
	pop  R0
	out  GPUY,		R0
	pop  R1
	out  GPUREG,	R1
	pop  R1
	out  GPUTEX,	R1
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
	mov  SP, BP
	pop  BP
	ret
	
; Initialize Memory
; Args: none
; Puts 0 into every
; memaddr
_gfinitmem:
_geninitmem:
_initmemsavestack:
	; Create local stack
	push BP
	mov  BP,        SP
	; Save our registers, texture, and region
	push R0
	push R1
_initmemmain:
	mov  R0,  0x00000000
_initmemloop:
	mov  R1,  0x00000000
	mov	[R0], R1
	iadd R0,  0x00000001
	mov	 R1,  R0
	ieq	 R1,  0x003FFFF2
	jf   R1,  _initmemloop
_initmemrestorestack:
	; Restore registers, texture, and region
	pop  R1
	pop  R0
	mov  SP, BP
	pop  BP
	ret

; Wait Frames
; Args: int frames
; Waits a specified amount
; of frames
_gfwaitframes:
_genwaitframes:
_waitframessavestack:
	; Create local stack
	push BP
	mov  BP,        SP
	; Save our registers, texture, and region
	push R0
	push R1
_waitframesarg:
	mov  R0,  [BP+2]
_waitframesmain:
	wait
	isub R0,  1
	mov  R1,  R0
	ile  R1,  0
	jf   R1,  _waitframesmain
_waitframesrestorestack:
	; Restore registers, texture, and region
	pop  R1
	pop  R0
	mov  SP, BP
	pop  BP
	ret

_gfend:
