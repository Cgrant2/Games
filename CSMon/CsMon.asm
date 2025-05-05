;;;;;;;;;;;
; DEFINES ;
;;;;;;;;;;;

; GPU Stuff
%define GPU_TEX  GPU_SelectedTexture
%define GPU_REG  GPU_SelectedRegion
%define GPU_X    GPU_DrawingPointX
%define GPU_Y    GPU_DrawingPointY
%define GPU_COM  GPU_Command
%define GPU_DRAW GPUCommand_DrawRegion

; INP Stuff
%define INP_GP    INP_SelectedGamepad
%define INP_LEFT  INP_GamepadLeft
%define INP_RIGHT INP_GamepadRight
%define INP_UP    INP_GamepadUp
%define INP_DOWN  INP_GamepadDown
%define INP_A     INP_GamepadButtonA
%define INP_B     INP_GamepadButtonB
%define INP_X     INP_GamepadButtonX
%define INP_Y     INP_GamepadButtonY
%define INP_L     INP_GamepadButtonL
%define INP_R     INP_GamepadButtonR
%define INP_START INP_GamepadButtonStart

;;;;;;;;;;;;
; INCLUDES ;
;;;;;;;;;;;;
%define TILEWIDTH  32
%define TILEHEIGHT 32
%define AUTORR     10

%include "assets/includes/generalfuncts.s"
%include "assets/includes/TommysTools/debug.s"
%include "assets/includes/TommysTools/itoa.s"
%include "assets/includes/TommysTools/print.s"
%include "assets/includes/TommysTools/region.s"
%include "assets/includes/OverworldRender.s"
%include "assets/includes/OverworldInputs.s"
%include "assets/includes/BattleScene.s"
%include "assets/data/DAT0.s"
%include "assets/data/DAT1.s"
%include "assets/data/DAT2.s"

; SPU Stuff

_start:
	mov  R0, 0
	mov  R1, 0
	mov  R2, 3
	mov  R3, 4
	mov  R4, 0
	mov  R5, 0
	mov  R6, 32
	mov  R7, 32
	mov  R8, 0
	mov  R9, 0

;;
;;	Define texture 0
;;
	push R0	;Texture
	push R1	;Region
	push R2	;X #
	push R3	;Y #
	push R4	;Start X
	push R5	;Start Y
	push R6	;Width
	push R7	;Height
	push R8 ;X hot
	push R9 ;Y hot
	call _define_grid

;;
;;	Define texture 1
;;
	mov  R0, 1
	mov  R2, 4
	mov  R6, 31
	mov  R7, 31
	push R0	;Texture
	push R1	;Region
	push R2	;X #
	push R3	;Y #
	push R4	;Start X
	push R5	;Start Y
	push R6	;Width
	push R7	;Height
	push R8 ;X hot
	push R9 ;Y hot
	call _define_grid

;;
;;	Define texture 2
;;
	mov  R0, 2
	mov  R2, 8
	mov  R3, 6
	push R0	;Texture
	push R1	;Region
	push R2	;X #
	push R3	;Y #
	push R4	;Start X
	push R5	;Start Y
	push R6	;Width
	push R7	;Height
	push R8 ;X hot
	push R9 ;Y hot
	call _define_grid

;;
;;	Define texture 3
;;
	mov  R0, 3
	mov  R2, 6
	mov  R3, 5
	mov  R6, 96
	mov  R7, 96
	push R0	;Texture
	push R1	;Region
	push R2	;X #
	push R3	;Y #
	push R4	;Start X
	push R5	;Start Y
	push R6	;Width
	push R7	;Height
	push R8 ;X hot
	push R9 ;Y hot
	call _define_grid

;;
;;	Define texture 4
;;
	mov  R0, 4
	mov  R1, 0 ;Battle menu options
	mov  R2, 1
	mov  R3, 167
	mov  R4, 1
	mov  R5, 272
	mov  R6, 1
	mov  R7, 1
	push R0 ;Texture
	push R1 ;Region
	push R2 ;Min x
	push R3 ;Max x
	push R4 ;Min y
	push R5 ;Max y
	push R6 ;Hotspot x
	push R7 ;Hotspot y
	call _define_region

	mov  R1, 1 ;Battle menu blank
	mov  R2, 169
	mov  R3, 335
	mov  R4, 1
	mov  R5, 272
	mov  R6, 169
	mov  R7, 1
	push R0 ;Texture
	push R1 ;Region
	push R2 ;Min x
	push R3 ;Max x
	push R4 ;Min y
	push R5 ;Max y
	push R6 ;Hotspot x
	push R7 ;Hotspot y
	call _define_region

	mov  R1, 2 ;Main menu
	mov  R2, 337
	mov  R3, 561
	mov  R4, 110
	mov  R5, 272
	mov  R6, 337
	mov  R7, 110
	push R0 ;Texture
	push R1 ;Region
	push R2 ;Min x
	push R3 ;Max x
	push R4 ;Min y
	push R5 ;Max y
	push R6 ;Hotspot x
	push R7 ;Hotspot y
	call _define_region

	mov  R1, 3 ;Text Box
	mov  R2, 1
	mov  R3, 609
	mov  R4, 274
	mov  R5, 337
	mov  R6, 1
	mov  R7, 274
	push R0 ;Texture
	push R1 ;Region
	push R2 ;Min x
	push R3 ;Max x
	push R4 ;Min y
	push R5 ;Max y
	push R6 ;Hotspot x
	push R7 ;Hotspot y
	call _define_region

	mov  R1, 4 ;Menu pointer
	mov  R2, 337
	mov  R3, 343
	mov  R4, 95
	mov  R5, 108
	mov  R6, 337
	mov  R7, 95
	push R0 ;Texture
	push R1 ;Region
	push R2 ;Min x
	push R3 ;Max x
	push R4 ;Min y
	push R5 ;Max y
	push R6 ;Hotspot x
	push R7 ;Hotspot y
	call _define_region


;;
;;	Define texture 5
;;
	mov  R0, 5
	mov  R1, 0
	mov  R2, 32
	mov  R3, 8
	mov  R4, 0
	mov  R5, 0
	mov  R6, 9
	mov  R7, 19
	mov  R8, 0
	mov  R9, 0
	push R0	;Texture
	push R1	;Region
	push R2	;X #
	push R3	;Y #
	push R4	;Start X
	push R5	;Start Y
	push R6	;Width
	push R7	;Height
	push R8 ;X hot
	push R9 ;Y hot
	call _define_grid

;;
;;	Define texture 6
;;
	mov  R0, 6
	mov  R1, 0 ;Battle background
	mov  R2, 0
	mov  R3, 639
	mov  R4, 0
	mov  R5, 359
	mov  R6, 0
	mov  R7, 0
	push R0 ;Texture
	push R1 ;Region
	push R2 ;Min x
	push R3 ;Max x
	push R4 ;Min y
	push R5 ;Max y
	push R6 ;Hotspot x
	push R7 ;Hotspot y
	call _define_region

	mov  R1, 1 ;Opponent platform
	mov  R2, 0
	mov  R3, 313
	mov  R4, 360
	mov  R5, 439
	mov  R6, 0
	mov  R7, 360
	push R0 ;Texture
	push R1 ;Region
	push R2 ;Min x
	push R3 ;Max x
	push R4 ;Min y
	push R5 ;Max y
	push R6 ;Hotspot x
	push R7 ;Hotspot y
	call _define_region

	mov  R1, 2 ;Player platform
	mov  R2, 0
	mov  R3, 509
	mov  R4, 441
	mov  R5, 514
	mov  R6, 0
	mov  R7, 514
	push R0 ;Texture
	push R1 ;Region
	push R2 ;Min x
	push R3 ;Max x
	push R4 ;Min y
	push R5 ;Max y
	push R6 ;Hotspot x
	push R7 ;Hotspot y
	call _define_region

;;
;;	Define texture 7
;;
	mov  R0, 7
	mov  R1, 0 ;Matt tile
	mov  R2, 98
	mov  R3, 129
	mov  R4, 1
	mov  R5, 32
	mov  R6, 98
	mov  R7, 1
	push R0 ;Texture
	push R1 ;Region
	push R2 ;Min x
	push R3 ;Max x
	push R4 ;Min y
	push R5 ;Max y
	push R6 ;Hotspot x
	push R7 ;Hotspot y
	call _define_region

	mov  R0, 7
	mov  R1, 2 ;Matt blank
	mov  R2, 1
	mov  R3, 1
	mov  R4, 1
	mov  R5, 1
	mov  R6, 1
	mov  R7, 1
	push R0 ;Texture
	push R1 ;Region
	push R2 ;Min x
	push R3 ;Max x
	push R4 ;Min y
	push R5 ;Max y
	push R6 ;Hotspot x
	push R7 ;Hotspot y
	call _define_region

;;
;; Initialize player team
;;
	mov  R4, 6
	mov  [PlayerMonCNT], R4
	mov  R4, 0
	mov  [InBatPlayer], R4
	mov  CR, PartySize
	mov  R4, _DEX
	iadd R4, 8
	mov  SR, [R4]
	mov  DR, PlayerTeam
	movs

	;mov  R0,   _test_town_TILEMAP
	;mov  R0,   _test_map_TILEMAP
	mov  R0,   _start_town_TILEMAP

	mov  R1,   320
	mov  R2,   224


;	R0 : tile map address
;	R1 : Xpos
;	R2 : Ypos
;	R3 : game status (overworld, battle, etc.)
;	R9 : temp/misc/test
_main:
	push R1
	push R2
	push R0
	call _OVW_INP
	pop  R3
	mov  R9, R3
	ieq  R9, 1
	jt   R9, __main_battle
	mov  R9, R3
	ieq  R9, 0
	jt   R9, __main_overworld
__main_overworld:
	pop  R0
	pop  R2
	pop  R1

	push R0
	push R1
	push R2
	call _draw_tile_map

	mov  R4, _gym_TILEMAP
	ieq  R4, R0
	jf   R4, __mattSkip

	mov  R4, _matt_TILEMAP
	push R4
	push R1
	push R2
	call _draw_tile_map

__mattSkip:
	wait
	jmp  _main
__main_battle:
	pop  R4
	pop  R2
	pop  R1

	push R4
	call _battleStart
	wait
	jmp  _main

_initstuff:
	hlt
