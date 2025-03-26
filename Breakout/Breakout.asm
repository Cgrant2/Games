; General Usage Stuff
	%include "assets/generalfuncts.s"
;	%include "assets/debug.s"
	%define	GPUCOM		GPU_Command
	%define	GPUTEX		GPU_SelectedTexture
	%define	GPUREG		GPU_SelectedRegion
	%define	DRAWR		GPUCommand_DrawRegion
	%define	DRAWZR		GPUCommand_DrawRegionZoomed
	%define GPUX		GPU_DrawingPointX
	%define GPUY		GPU_DrawingPointY
	%define GPUZX		GPU_DrawingScaleX
	%define GPUZY		GPU_DrawingScaleY

	%define	SPUCOM		SPU_Command

	%define INP_GP		INP_SelectedGamepad
	%define INLEFT		INP_GamepadLeft
	%define INRIGHT		INP_GamepadRight

	%define BallX	R0
	%define BallY	R1
	%define BalldX	R2
	%define BalldY	R3
	%define PadX	R4
	%define BOOL	R5
	%define Lives	R13
	%define	PadY	352 

	%define BlockStart	0x00000000
	%define BlockActive	0
	%define BlockX		1
	%define BlockY		2
	%define BlockSize	3 
	%define BlockEnd	0x00000120

; Initialize stuff
	out 	INP_GP,	0
	mov		BP,		0x003FFFFF
	mov		SP,		0x003FFFFF

; Set up regions
	mov 	R0, 	0		; RegionId
	mov 	R1, 	0		; MinX
	mov 	R2, 	0		; MinY
	mov 	R3, 	15		; MaxX
	mov 	R4, 	15		; MaxY
	mov 	R5, 	0		; HotspotX
	mov 	R6, 	0		; HotspotY
_defineRegions:
	out 	GPUTEX, 			1 		; Texture 1 - Background
	out 	GPUREG, 			0		; REGION 0 - Ball
	out 	GPU_RegionMinX, 	0
	out 	GPU_RegionMinY, 	0
	out 	GPU_RegionMaxX, 	639
	out 	GPU_RegionMaxY, 	359
	out 	GPU_RegionHotspotX, 0
	out 	GPU_RegionHotspotY, 0

	out 	GPUTEX,	0					; Texture 0 - Sprites
	out 	GPUREG, 			R0		; REGION 0 - Ball
	out 	GPU_RegionMinX, 	R1
	out 	GPU_RegionMinY, 	R2
	out 	GPU_RegionMaxX, 	R3
	out 	GPU_RegionMaxY, 	R4
	out 	GPU_RegionHotspotX, R5
	out 	GPU_RegionHotspotY, R6
	iadd 	R0, 				1		; Increase ID
	mov  	R1, 				48		; MinX
	mov  	R3, 				95		; MaxX
	mov 	R4, 				3		; MaxY
	mov		R5,					72		; Hotspot X (changed for easier math)
	out 	GPUREG, 			R0		; REGION 1 - Paddle
	out 	GPU_RegionMinX, 	R1
	out 	GPU_RegionMinY, 	R2
	out 	GPU_RegionMaxX, 	R3
	out 	GPU_RegionMaxY, 	R4
	out 	GPU_RegionHotspotX, R5
	out 	GPU_RegionHotspotY, R6
	iadd 	R0, 				1		; Increase ID
	mov  	R1, 				0		; MinX
	mov  	R2, 				16		; MinY
	mov  	R3, 				47		; MaxX
	mov 	R4, 				31		; MaxY
	mov		R5,					0		; Hotspot X
	out 	GPUREG, 			R0		; REGION 2 - Brick
	out 	GPU_RegionMinX, 	R1
	out 	GPU_RegionMinY, 	R2
	out 	GPU_RegionMaxX, 	R3
	out 	GPU_RegionMaxY, 	R4
	out 	GPU_RegionHotspotX, R5
_gamestart:
; Initialize gameplay stuff
	mov  BallX,		318
	mov  BallY,		300
	mov  BalldX,	3
	mov  BalldY,	-3
	mov  PadX,		320
	mov  Lives, 	5

; Initialize blocks
	mov  R6,		BlockStart
	mov  R7, 		1			; set to active
	mov  R8, 		26			; initial x
	mov  R9, 		20			; initial y
	mov  R10, 		12			; amount per row
	mov  R11, 		8 			; amount of rows
_blockinitrow:
	mov  [R6],			R7
	mov  [R6+BlockX],	R8
	mov  [R6+BlockY],	R9
	iadd R6, 			3
	iadd R8, 			49
	isub R10, 			1
	mov  BOOL, 			R10
	ieq  BOOL, 			0
	jf   BOOL, 			_blockinitrow
_blockinitnextrow:
	mov  R8, 			26
	iadd R9, 			16
	mov  R10,			12
	isub R11,			1
	mov  BOOL, 			R11
	ieq  BOOL, 			0
	jf   BOOL, 			_blockinitrow

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                         ;
; Start the gameplay loop ;
;                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
_mainLoop:
	out		GPUTEX,				1
	out 	GPUREG,				0
	out 	GPUX,				0
	out 	GPUY,				0
	out 	GPUCOM, 			DRAWR
	out		GPUTEX,				0
	mov 	R6, 				Lives
	mov 	R7, 				0
_drawlives:
	mov 	BOOL, 				R6
	igt 	BOOL, 				0
	jf  	BOOL, 				_mainloopcont
	out		GPUTEX,				0
	out 	GPUREG,				0
	out 	GPUX,				R7
	out 	GPUY,				344
	out 	GPUCOM, 			DRAWR
	isub 	R6, 				1
	iadd 	R7, 				17
	jmp 	_drawlives
	
_mainloopcont:
	call	_movePad
	call	_blocks
	call 	_moveBall
	wait
	mov 	BOOL, 				Lives
	ilt 	BOOL, 				0
	jf 		BOOL,				_mainLoop
_gamelost:
	mov 	R6, 				__deathstr
	push 	R6
	mov 	R6, 			 	265
	push 	R6
	mov 	R6, 				170	
	push 	R6
	call 	_gfprint
	pop 	R6
	pop 	R6
	pop 	R6
	mov 	R6, 				120
	push 	R6
	call 	_gfwaitframes
	pop 	R6
	jmp 	_gamestart


;;;;;;;;
; BALL ;
;;;;;;;;
_moveBall:
	;Increment X and Y
	iadd 	BallX,  BalldX
	iadd 	BallY, 	BalldY
	out 	GPUX, 	BallX
	out 	GPUY, 	BallY
	out 	GPUREG, 0
	out 	GPUCOM, DRAWR
	;Check if it hit bottom or top of screen
	mov 	BOOL, 	BallY
	igt 	BOOL, 	360
	jt  	BOOL, 	_balldead
	mov 	BOOL, 	BallY
	ige 	BOOL, 	334
	jt 		BOOL, 	_padcol
	mov 	BOOL, 	R1
	ile 	BOOL, 	0
	jt 		BOOL, 	_topcol
	; Check if it has hit either side of the screen
	mov 	BOOL, 	BallX
	ige 	BOOL, 	604
	jt 		BOOL, 	_rightcol 
	mov 	BOOL, 	BallX
	ile 	BOOL, 	20
	jt 		BOOL, 	_leftcol
	ret
_leftcol:
	mov 	BallX, 	21
	jmp 	_reflectedX
_rightcol:
	mov 	BallX, 	603
_reflectedX:
	isgn 	R2
	call	_BEEP
	ret
_padcol:
	mov 	R7, 	BallX
	isub 	R7, 	PadX
	mov 	R8, 	R7
	iabs 	R7
	mov 	BOOL, 	R7
	ile 	BOOL,	48
	jf  	BOOL, 	_return

	idiv 	R7,		12
	iadd 	R7, 	5
	mov 	BOOL,	BalldX
	ilt 	BOOL,	0
	jf  	BOOL, 	_right
_left:
	mov 	BOOL, 	R8
	igt 	BOOL,	0
	jf		BOOL, 	_lrightside
_lleftside:
	mov 	BalldY, R7
	mov  	BalldX, -3
	jmp 	_reflectedY
_lrightside:
	mov 	BalldX, R7
	;isgn 	BalldX
	jmp 	_reflectedY
_right:
	mov 	BOOL, 	R8
	ilt 	BOOL,	0
	jf		BOOL, 	_rleftside
_rrightside:
	mov 	BalldY, R7
	mov  	BalldX, -3
	jmp 	_reflectedY
_rleftside:
	mov 	BalldX, R7
	;isgn 	BalldX
	jmp 	_reflectedY
_topcol:
	mov 	BallY,	1
_reflectedY:
	isgn 	R3
	call	_BEEP
_return:
	ret
_balldead:
	mov 	BallX, 	PadX
	mov 	BallY, 	335
	mov 	BalldY, -4
	mov 	BalldX, 4
	isub 	Lives, 	1

	mov 	R8, 	60
	push 	R8
	call _gfwaitframes
	pop 	R8
	ret

;;;;;;;;;;
; PADDLE ;
;;;;;;;;;;

_movePad:
	in  	R6,		INLEFT	
	igt 	R6,		0
	jt  	R6, 	_padleft
	in  	R6,		INRIGHT	
	igt 	R6,		0
	jt  	R6, 	_padright
	jmp 	_drawpad
_padleft:
	mov 	BOOL, 	PadX
	ile 	BOOL, 	56
	jt  	BOOL, 	_drawpad
	isub 	PadX, 	8
	jmp 	_drawpad
_padright:
	mov 	BOOL, 	PadX
	ige 	BOOL, 	584
	jt  	BOOL, 	_drawpad
	iadd 	PadX, 	8
_drawpad:
	out 	GPUX, 	PadX
	out 	GPUY, 	PadY
	mov 	R6, 	2
	cif 	R6
	out 	GPUZX, R6
	out 	GPUTEX,	0
	out 	GPUREG,	1
	out 	GPUCOM, DRAWZR
	ret

;;;;;;;;;;
; BLOCKS ;
;;;;;;;;;;
_blocks:
	mov 	R6,		BlockStart
_blockloop:
	mov 	BOOL, 	[R6]
	ieq 	BOOL,	0
	jt  	BOOL,	_blocknext
_blockcol:
	mov 	R7, 	[R6+BlockX]
	mov 	R8, 	[R6+BlockY]
	; Ball within block Y bounds
	mov		R9,		R8
	iadd 	R9,		17
	mov 	BOOL,	BallY
	ile 	BOOL,	R9
	jf  	BOOL,	_drawblock
	mov 	BOOL,	BallY
	iadd	BOOL,	16
	ige 	BOOL,	R8
	jf  	BOOL,	_drawblock
	; Ball within block X bounds
	mov 	BOOL,	BallX
	ige		BOOL,	R7
	jf		BOOL,	_drawblock
	mov 	R9,		R7
	iadd 	R9,		49
	mov 	BOOL,	BallX
	ile		BOOL,	R9
	jf 		BOOL,	_drawblock
	mov 	R9,		0
	mov 	[R6],	R9
	isgn 	BalldY
_drawblock:
	out 	GPUTEX,	0
	out 	GPUREG,	2
	out 	GPUX,	R7
	out 	GPUY,	R8
	out		GPUCOM, DRAWR
_blocknext:
	iadd 	R6,		BlockSize
	mov 	BOOL,	R6
	ieq 	BOOL,	BlockEnd
	jf  	BOOL,	_blockloop
	ret

;;;;;;;;;
; SOUND ;
;;;;;;;;;
_BEEP:
	out 	SPU_SelectedSound, 			0
	out 	SPU_SelectedChannel, 		1
	out 	SPU_ChannelAssignedSound, 	0
	out 	SPUCOM, SPUCommand_PlaySelectedChannel
	ret

;;;;;;;;;;;
; STRINGS ;
;;;;;;;;;;;
__deathstr:
	string "You Lost =("
