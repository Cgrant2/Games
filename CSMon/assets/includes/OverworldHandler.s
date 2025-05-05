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
;
; Overworld Handler: Handles the overworld scene
;

	jmp  _end   ; avoid uncalled instructions

_OverWorld:
	mov  R0, 0          ; Menu Flag                     ;0-no menu 1-menu;
	mov  R1, 0          ; Interact Flag                 ;0-no dialogue box 1-dialogue box;
	;    R2             ; Boolean register
	mov  R3, 0          ; Flag for which dir is pressed ;0-left 1-right 2-up 3-down 4-none;

_OVW_Input:

	mov  R3, 0
	jt   R0, OVW_INP_MENU ; If the menu flag is set, go to the menu handler
	;jt   R1, OVW_INP_INTER ; If the menu flag is set, go to the interact handler
	                 

	;in   R2, INP_A        ; +========================================
	;igt  R2, 0            ; | retrieve 'A' input, jump to interaction
	;jt   R2, _OVW_INP_INTER;+========================================

	in   R2, INP_LEFT     ; +================================================   
	igt  R2, 0            ; |
	jt   R2, _OVW_DIR_L   ; |
	iadd R3, 1            ; |
	                      ; |
	in   R2, INP_RIGHT    ; |
	igt  R2, 0            ; |
	jt   R2, _OVW_DIR_R   ; |
	iadd R3, 1            ; |
	                      ; | retrieve directional input and jump to movement
	in   R2, INP_UP       ; |
	igt  R2, 0            ; |
	jt   R2, _OVW_DIR_U   ; |
	iadd R3, 1            ; |
	                      ; |
	in   R2, INP_DOWN     ; |
	igt  R2, 0            ; |
	jt   R2, _OVW_DIR_D   ; |
	iadd R3, 1            ; +================================================

	in   R2, INP_START    ; +======================================
	igt  R2, 0            ; | Retrieve 'start' input
	jf   R2, _OVW_INP_END ; | set menu flag
	mov  R3, 1            ; +======================================

_OVW_INP_END:
	ret                   ; | No input recieved, return to call

;_OVWINPMOV
_OVW_DIR_L:
	;add 32px/1tile to map x
	;check if colliding with solid tile, if so undo move
	;check if special tile: Grass+rng or trainer line of sight --> change scene
_OVW_DIR_R:
	;sub 32px/1tile to map x
	;check if colliding with solid tile, if so undo move
	;check if special tile: Grass+rng or trainer line of sight --> change scene
_OVW_DIR_U:
	;add 32px/1tile to map x
	;check if colliding with solid tile, if so undo move
	;check if special tile: Grass+rng or trainer line of sight --> change scene
_OVW_DIR_D:
	;sub 32px/1tile to map x
	;check if colliding with solid tile, if so undo move
	;check if special tile: Grass+rng or trainer line of sight --> change scene

_OVW_INP_MENU:
	;;Menu is open, all input redirected here
	;d-pad move cursor up/down

_OVW_INP_INTER:


_OVW_Tiles:

_end:
