; General Usage Stuff
	%define	GPUCOM		GPU_Command
	%define	GPUTEX		GPU_SelectedTexture
	%define	GPUREG		GPU_SelectedRegion
	%define	DRAWREG		GPUCommand_DrawRegion
	%define	DRAWZREG	GPUCommand_DrawRegionZoomed
	%define DRAWX		GPU_DrawingPointX
	%define DRAWY		GPU_DrawingPointY
	%define SCALEX		GPU_DrawingScaleX
	%define SCALEY		GPU_DrawingScaleY

	%define	SPUCOM		SPU_Command

	%define LPoint		0x00000001
	%define RPoint		0x00000002
	%define StrLen		0x00000003

; Initialize stuff
	out 	GPUTEX, 					0
	out 	INP_SelectedGamepad, 		0
	mov		BP,							0x003FFFFF
	mov		SP,							0x003FFFFF

; Set up regions
	mov 	R0, 	0		; RegionId
	mov 	R1, 	0		; MinX
	mov 	R2, 	0		; MinY
	mov 	R3, 	31		; MaxX
	mov 	R4, 	31		; MaxY
	mov 	R5, 	0		; HotspotX
	mov 	R6, 	0		; HotspotY
_defineRegions:
	out 	GPUREG, 			R0
	out 	GPU_RegionMinX, 	R1
	out 	GPU_RegionMinY, 	R2
	out 	GPU_RegionMaxX, 	R3
	out 	GPU_RegionMaxY, 	R4
	out 	GPU_RegionHotspotX, R5
	out 	GPU_RegionHotspotY, R6
	iadd 	R0, 				1
	iadd 	R1, 				32 
	iadd 	R3, 				32 
	iadd 	R5, 				32
	mov 	R6, 				R0
	ieq 	R6, 				2
	jf 		R6, 				_defineRegions

; Initialize gameplay stuff
	mov 	R0, 	  320	; BallX
	mov 	R1, 	  180 	; BallY
	mov 	R2, 	  4   	; BallDX
	mov 	R3, 	  4   	; BallDY
	mov 	R4,		  100 	; PaddleLeftY
	mov 	R5,		  100	; PaddleRightY
	mov		R6, 	  0
	mov		[LPoint], R6
	mov		[RPoint], R6

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                         ;
; Start the gameplay loop ;
;                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
_mainLoop:
	out		GPUTEX,				0
	out 	GPUCOM, 			GPUCommand_ClearScreen
	call 	_moveBall
	call 	_movePaddleRight
	call 	_movePaddleLeft
	; Draw Left's Points
	mov		R10,				[LPoint]
	mov		R13,				30
	call	_printnum
	; Draw Right's Points
	mov		R10,				[RPoint]
	mov		R13,				598
	call	_printnum

	wait
	jmp 	_mainLoop

_printnum:
	out		GPUTEX,				-1
	mov		R12,				0
	push	R12
_itoa:
	; Place each digit of the number onto the stack
	mov		R11,				R10
	imod	R11,				10
	idiv	R10,				10
	iadd	R11,				0x30
	push	R11
	mov		R11,				R10
	ieq		R11,				0
	jf		R11,				_itoa
_innerprintloop:
	pop		R7
	mov		R6,					R7
	ieq		R6,					0
	jt		R6,					_return
	out		DRAWX,				R13
	out		DRAWY,				5
	out		GPUREG,				R7
	out		GPUCOM,				DRAWREG
	iadd	R13,				10
	jmp _innerprintloop
_return:
	ret


_moveBall:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Ball region is 32x32, ball actual image is 8x8
; R0 = BallX
; R1 = BallY
; R2 = BallDX
; R3 = BallDY
; R4 = LPadY, LPadX=8
; R5 = RPadY, RPadX=600
; R6 = Comparison Register
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Increment X and Y
	iadd 	R0, 	R2
	iadd 	R1, 	R3
	out 	DRAWX, 	R0
	out 	DRAWY, 	R1
	out 	GPUREG, 1
	out 	GPUCOM, DRAWREG
	;Check if it hit bottom or top of screen
	mov 	R6, 	R1
	ige 	R6, 	332
	jt 		R6, 	_reflectedY
	mov 	R6, 	R1
	ile 	R6, 	-4
	jt 		R6, 	_reflectedY
	; Check if it has exited either side of the screen
	mov 	R6, 	R0
	ige 	R6, 	652
	jt 		R6, 	_offRight 
	mov 	R6, 	R0
	ile 	R6, 	-32
	jt 		R6, 	_offLeft
	;Check if it has hit a paddle
	mov 	R6, 	R0
	ieq 	R6, 	596
	jt 		R6, 	_ballCollideR
	mov 	R6, 	R0
	ieq 	R6, 	12
	jt 		R6, 	_ballCollideL
	ret
_ballCollideR:
	mov 	R6, 	R1
	ige 	R6, 	R5
	jt 		R6, 	_rPadBelow
	ret
_ballCollideL:
	mov 	R6, 	R1
	ige 	R6, 	R4
	jt 		R6, 	_lPadBelow
	ret
_reflectedX:
	isgn 	R2
	call	_BEEP
	ret
_reflectedY:
	isgn 	R3
	call	_BEEP
	ret
_offRight:
	isgn 	R2
	mov 	R0, 	  316
	mov 	R1, 	  176
	mov		R10,	  [LPoint]
	iadd	R10,	  1
	mov		[LPoint], R10
	ret
_offLeft:
	isgn 	R2
	mov 	R0, 	  316
	mov 	R1, 	  176
	mov		R10,	  [RPoint]
	iadd	R10,	  1
	mov		[RPoint], R10
	ret
_rPadBelow:
	mov 	R6, 	R1
	mov 	R10, 	R5
	iadd 	R10, 	96
	ile 	R6, 	R10
	jt 		R6, 	_reflectedX
	ret

_lPadBelow:
	mov 	R6, 	R1
	mov 	R10, 	R4
	iadd 	R10, 	96
	ile 	R6, 	R10
	jt 		R6, 	_reflectedX
	ret

_movePaddleRight:
	;equivilent to an "up" subroutine
	mov 	R8, 	600
	mov 	R6, 	R5
	in 		R7, 	INP_GamepadUp
	ige 	R7, 	1
	jf 		R7, 	_rdown
	ilt 	R6, 	0
	jt 		R6, 	_rdisplay
	isub 	R5, 	4
	jmp 	_rdisplay
_rdown:
	mov 	R6, 	R5
	in 		R7, 	INP_GamepadDown
	ige 	R7, 	1
	jf 		R7, 	_rdisplay
	igt 	R6, 	264
	jt 		R6, 	_rdisplay
	iadd 	R5, 	4
	jmp 	_rdisplay
_rdisplay:
	out 	GPUREG, 0
	mov 	R6, 	3
	cif 	R6
	out 	SCALEY, R6
	out 	DRAWX, 	R8
	out 	DRAWY, 	R5
	out 	GPUCOM, DRAWZREG
	ret
_movePaddleLeft:
	;equivilent to an "up" subroutine
	mov 	R8, 	8
	mov 	R6, 	R4
	in 		R7, 	INP_GamepadButtonX
	ige 	R7, 	1
	jf 		R7, 	_ldown
	ilt 	R6, 	0
	jt 		R6, 	_ldisplay
	isub 	R4, 	4
	jmp 	_ldisplay
_ldown:
	mov 	R6, 	R4
	in 		R7, 	INP_GamepadButtonB
	ige 	R7, 	1
	jf 		R7, 	_ldisplay
	igt 	R6, 	264
	jt 		R6, 	_ldisplay
	iadd 	R4, 	4
	jmp 	_ldisplay
_ldisplay:
	out 	GPUREG, 0
	mov 	R6, 	3
	cif 	R6
	out 	SCALEY, R6
	out 	DRAWX, 	R8
	out 	DRAWY, 	R4
	out 	GPUCOM, DRAWZREG
	ret
_BEEP:
	out 	SPU_SelectedSound, 			0
	out 	SPU_SelectedChannel, 		1
	out 	SPU_ChannelAssignedSound, 	0
	out 	SPUCOM, SPUCommand_PlaySelectedChannel
	ret
