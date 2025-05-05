; GPU Stuff
%define GPU_TEX  GPU_SelectedTexture
%define GPU_REG  GPU_SelectedRegion
%define GPU_X    GPU_DrawingPointX
%define GPU_Y    GPU_DrawingPointY
%define GPU_COM  GPU_Command
%define GPU_DRAW GPUCommand_DrawRegion
%define MULTCOLOR GPU_MultiplyColor

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

;;;;;;;;;;;
; DEFINES ;
;;;;;;;;;;;

%ifndef AUTORR
%define AUTORR 10              ;Auto Repeat Rate in frames per input
%endif

	jmp  _OverworldInputsEnd   ; avoid uncalled instructions

;;
;;
;; Overworld Input Handler
;;
;; int[4] OVW_INP( int XPos, int YPos, int* TileMap);
;;
;; Usage: push XPos
;;        push YPos
;;        push TileMap Address
;;        call OVW_INP
;;        pop  game status
;;        pop  TileMap Address/Monster Id
;;        pop  Ypos
;;        pop  Xpos
;;

_OVW_INP:
_OVW_INP_Setup:
	push R0             ; DUMMY used for padding (more out than in)
	push BP
	mov  BP, SP

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
	mov  R0, [BP+5]     ; XPos
	mov  R1, [BP+4]     ; YPos
	mov  R9, [BP+3]     ; TileMap

	mov  R2, 0          ; Menu Flag                     ;0-no menu 1-menu;
	mov  R3, 0          ; Interact Flag                 ;0-no dialogue box 1-dialogue box;
	;    R4             ; Boolean register
	mov  R5, 0          ; Flag for which dir is pressed ;0-left 1-right 2-up 3-down 4-none;
	mov  R7, 0          ; Game status Flag

_OVW_Input:

	mov  R5, 0
	jt   R2, _OVW_INP_MENU ; If the menu flag is set, go to the menu handler
	jt   R3, _OVW_INP_INTER; If the interact flag is set, go to the interact handler
	                 

	in   R4, INP_A        ; +========================================
	ieq  R4, 1            ; | retrieve 'A' input, jump to interaction
	jt   R4, _OVW_INP_INTER;+========================================

	in   R4, INP_LEFT     ; +================================================   
	imod R4, AUTORR
	ieq  R4, 1            ; |
	jt   R4, _OVW_DIR_L   ; |
	                      ; |
	in   R4, INP_RIGHT    ; |
	imod R4, AUTORR
	ieq  R4, 1            ; |
	jt   R4, _OVW_DIR_R   ; |
	                      ; | retrieve directional input and jump to movement
	in   R4, INP_UP       ; |
	imod R4, AUTORR
	ieq  R4, 1            ; |
	jt   R4, _OVW_DIR_U   ; |
	                      ; |
	in   R4, INP_DOWN     ; |
	imod R4, AUTORR
	ieq  R4, 1            ; |
	jt   R4, _OVW_DIR_D   ; +================================================

	;in   R4, INP_START    ; +======================================
	;ieq  R4, 1            ; | Retrieve 'start' input
	;jf   R4, _OVW_INP_END ; | set menu flag
	;mov  R5, 1            ; +======================================

	jmp _OVW_INP_RESTORE  ; | No input recieved, return to call

;_OVWINPMOV
_OVW_DIR_L:
	;sub 32px/1tile to player x
	;IF TILE LEFT COLID == 1, play sound no move
	isub R0, 32
	;check if colliding with solid tile, if so undo move
	push R9                         ; +=================================
	push R0                         ; |
	push R1                         ; | retrieve the collsion map value
	call _CHK_collision_map         ; |
	pop  R6                         ;
	mov  R7, R6                     ; |
	ieq  R7, 1                      ; | move the player back
	imul R7, 32                     ; |
	iadd R0, R7                     ; +=================================
	;check if special tile: Grass+rng or trainer line of sight --> change scene

	jmp _OVW_INP_END                ; | Input handled, Return to call
_OVW_DIR_R:
	;add 32px/1tile to player x
	iadd R0, 32
	;check if colliding with solid tile, if so undo move
	push R9                         ; +=================================
	push R0                         ; |
	push R1                         ; | retrieve the collsion map value
	call _CHK_collision_map         ; |
	pop  R6                         ;
	mov  R7, R6                     ; |
	ieq  R7, 1                      ; | move the player back
	imul R7, 32                     ; |
	isub R0, R7                     ; +=================================
	;check if special tile: Grass+rng or trainer line of sight --> change scene

	jmp _OVW_INP_END                ; | Input handled, Return to call
_OVW_DIR_U:
	;sub 32px/1tile to player x
	isub R1, 32
	;check if colliding with solid tile, if so undo move
	push R9                         ; +=================================
	push R0                         ; |
	push R1                         ; | retrieve the collsion map value
	call _CHK_collision_map         ; |
	pop  R6                         ;
	mov  R7, R6                     ; |
	ieq  R7, 1                      ; | move the player back
	imul R7, 32                     ; |
	iadd R1, R7                     ; +=================================
	;check if special tile: Grass+rng or trainer line of sight --> change scene

	jmp _OVW_INP_END                ; | Input handled, Return to call
_OVW_DIR_D:
	;add 32px/1tile to player x
	iadd R1, 32
	;check if colliding with solid tile, if so undo move
	push R9                         ; +=================================
	push R0                         ; |
	push R1                         ; | retrieve the collsion map value
	call _CHK_collision_map         ; |
	pop  R6                         ;
	mov  R7, R6                     ; |
	ieq  R7, 1                      ; | move the player back
	imul R7, 32                     ; |
	isub R1, R7                     ; +=================================
	;check if special tile: Grass+rng or trainer line of sight --> change scene

	jmp _OVW_INP_END                ; | Input handled, Return to call

_OVW_INP_MENU:
	;;Menu is open, all input redirected here
	;d-pad move cursor up/down

_OVW_INP_INTER:
	push R9                         ; +=================================
	push R0                         ; |
	push R1                         ; | retrieve the collsion map value
	call _CHK_collision_map         ; | and call  the dialogue function
	push R9
	call _dialogue_CHK              ; +=================================

	jmp _OVW_INP_RESTORE


_OVW_INP_END:
	push R6                         ; +=================================
	push R9                         ; |
	push R0                         ; | Call the map change function
	push R1                         ; |
	call _map_change_CHK            ; |
	pop  R1                         ; |
	pop  R0                         ; |
	pop  R9                         ; +=================================

	push R6                         ; +=================================
	push R9                         ; |
	call _encounter_CHK             ; | Call the encouter check function
	pop  R7                         ; |
	pop  R8                         ; +=================================

	jt   R7, _OVW_INP_ENCOUNTER
	jf   R7, _OVW_INP_RESTORE

_OVW_INP_ENCOUNTER:
	mov  R9, R8

_OVW_INP_RESTORE:
	mov  R2, [BP+2]
	mov  [BP+1], R2
	mov  [BP+5], R0
	mov  [BP+4], R1
	mov  [BP+3], R9
	mov  [BP+2], R7
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Encoutner Tile function
;;;      Determines if an encoutner happens and returns ecounter data
;;;
;;;   Usage:
;;;
;;;   Push  tile value
;;;   Push  TileMap address
;;;   Call  _dialogue_CHK
;;;
_dialogue_CHK:
	push BP
	mov  BP, SP

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
	mov  R0, [BP+3]     ; Tile Value
	mov  R1, [BP+2]     ; TileMap

	mov  R2, R0                   ; +===========
	mov  R3, R0                   ; |
	ige  R2, 2                    ; | Check for
	ilt  R3, 10                   ; | dialogue
	and  R2, R3                   ; |
	jt   R2, __dialogue_CHK_begin ; +===========
	jmp  __dialogue_CHK_end

__dialogue_CHK_begin:
	mov  R2, [R1]                 ; +======================
	mov  R3, [R1+1]               ; |
	imul R2, R3                   ; | Change map address to
	iadd R1, R2                   ; | the  dialogue section
	iadd R1, 3                    ; |
	mov  R3, [R1]                 ; |
	mov  R4, [R1+1]               ; |
	imul R3, 3                    ; |
	imul R4, 3                    ; |
	iadd R1, 2                    ; |
	iadd R1, R2                   ; |
	iadd R1, R3                   ; |
	iadd R1, R4                   ; +======================

	mov  R0, [R1]                 ; Get the text pointer
	mov  R2, [R1+2]               ;     the dialog count
	mov  R1, [R1+1]               ; and the npc ID#

	mov  R3, 50                   ; Xpos
	mov  R4, 291                  ; Ypos

__dialogue_CHK_loop:
	mov   R6, 4
	push  R6
	mov   R6, 3
	push  R6
	mov   R6, 14
	push  R6
	mov   R6, 282
	push  R6
	call _draw_region_at

; TODO print NPC sprite

	in   R6, MULTCOLOR
	push R6
	out  MULTCOLOR, 0xFF000000

	push R0
	call _stringLenMEM
	pop  R5

	push R0                       ; +=================
	push R3                       ; |
	push R4                       ; | Display text
	call _printMEM                ; |
                                  ;
	isub R2, 1                    ; | Go to the next
	iadd R0, R5                   ; | section of text
	iadd R0, 1                    ; +=================

	pop  R6
	out  MULTCOLOR, R6

__dialogue_CHK_wait_loop:
	wait
	in   R6, INP_A
	ieq  R6, 1
	jf   R6, __dialogue_CHK_wait_loop

	jt   R2, __dialogue_CHK_loop

__dialogue_CHK_end:
	mov  R0, [BP+1]
	mov  [BP+3], R0
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
	iadd SP, 2
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Encoutner Tile function
;;;      Determines if an encoutner happens and returns ecounter data
;;;
;;;   Usage:
;;;
;;;   Push  tile value
;;;   Push  TileMap address
;;;   Call  _encounter_CHK
;;;   Pop   encounter flag
;;;   Pop   monster id
;;;
_encounter_CHK:
	push BP
	mov  BP, SP

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
	mov  R0, [BP+3]     ; Tile Value
	mov  R1, [BP+2]     ; TileMap

	mov  R4, R0                   ; +===========
	mov  R5, R0                   ; |
	ige  R4, 36                   ; | Check for
	ilt  R5, 62                   ; | encounter
	and  R4, R5                   ; |
	jt   R4, __encounter_CHK_true ; +===========

	jmp  __encounter_CHK_fail     ; Fall through

__encounter_CHK_true:
	mov  R4, [R1]                 ; +======================
	mov  R5, [R1+1]               ; |
	imul R4, R5                   ; | Change map address to
	iadd R1, R4                   ; | the encounter section
	iadd R1, 3                    ; |
	mov  R5, [R1]                 ; |
	imul R5, 3                    ; |
	iadd R1, R4                   ; |
	iadd R1, 2                    ; |
	iadd R1, R5                   ; +======================
	isub R0, 36
	imul R0, 2
	iadd R1, R0

	in   R2, RNG_CurrentValue     ; Get  random   number
	imod R2, 1000000              ; for  determining  if
	cif  R2                       ; an encounter happens
	fdiv R2, 1000000              ;

	mov  R0, [R1]                 ; Initialize   data
	mov  R1, [R1+1]               ; for the encounter
	flt  R2, R1                   ; Check if encounter
	jf   R2, __encounter_CHK_fail ; happens

	in   R2, RNG_CurrentValue     ; Get random number
	imod R2, 1000000              ; to  choose  which
	cif  R2                       ; monster  to  find
	fdiv R2, 1000000              ;

__encounter_CHK_loop:
	mov  R1, [R0]
	fgt  R1, 1.00
	jt   R1, __encounter_boss
	mov  R1, [R0]                 ; Check  if  random  number
	mov  R3, R2                   ; is less than the % chance
	flt  R3, R1                   ;
	jt   R3, __encounter_CHK_loop_end
	fsub R2, R1                   ; Decrease the random number
	iadd R0, 2                    ; by the % chance that failed
	jmp  __encounter_CHK_loop     ;

__encounter_CHK_loop_end:
	mov  R2, 1                    ; Return that an ecounter
	mov  R1, [R0+1]               ; happened  and the id of
	jmp  __encounter_CHK_end      ; the  monster ecountered

__encounter_CHK_fail:
	mov  R2, 0                    ; Return  that  no
	mov  R1, 0                    ; ecounter happened
	jmp  __encounter_CHK_end

__encounter_boss:
	mov  R2, 1
	mov  R1, 99

__encounter_CHK_end:
	mov  [BP+3], R1
	mov  [BP+2], R2
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Map Change Tile function
;;;      Updates player position & tilemap if on map change tile
;;;
;;;   Usage:
;;;
;;;   Push  tile value
;;;   Push  TileMap address
;;;   Push  Player X cord
;;;   Push  Player Y cord
;;;   Call  _map_change_CHK
;;;   Pop   Player Y cord
;;;   Pop   Player X cord
;;;   Pop   TileMap address
;;;
_map_change_CHK:
	push BP
	mov  BP, SP

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
	mov  R0, [BP+5]     ; Tile Value
	mov  R1, [BP+4]     ; TileMap
	mov  R2, [BP+3]     ; XPos
	mov  R3, [BP+2]     ; YPos

	mov  R4, R0                   ; +============
	mov  R5, R0                   ; |
	ige  R4, 10                   ; | Check  for
	ilt  R5, 36                   ; | map change
	and  R4, R5                   ; |
	jt   R4, __map_change_CHK_true; +============

	jmp  __map_change_CHK_end     ; Fall through

__map_change_CHK_true:
	mov  R4, [R1]                 ; +==========================
	mov  R5, [R1+1]               ; |
	imul R4, R5                   ; | Move  tile  map  address
	imul R4, 2                    ; | to the map change section
	iadd R1, R4                   ; |
	iadd R1, 5                    ; +==========================

	isub R0, 10                   ; Move address to specific
	imul R0, 3                    ; map change section
	iadd R1, R0

	mov  R2, [R1+1]               ; +======================
	mov  R3, [R1+2]               ; |
	mov  R1, [R1]                 ; | Update  the  return
	imul R2, TILEWIDTH            ; | values with new data
	imul R3, TILEHEIGHT           ; |
	jmp  __map_change_CHK_end     ; +======================

__map_change_CHK_end:
	mov  R0, [BP+1]
	mov  [BP+2], R0
	mov  [BP+5], R1
	mov  [BP+4], R2
	mov  [BP+3], R3
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
	iadd SP, 1
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   check collision value
;;;      Gets the value of the current tile the player is on
;;;
;;;   Usage:
;;;
;;;   Push  Tile map (mem address / lable)
;;;   Push  Player X cord
;;;   Push  Player Y cord
;;;   Call _draw_tile_map
;;;   Pop   Tile value
;;;

;	R0	Mem address
;	R1	Map width
;	R2	Map height
;	R3	Player X pos
;	R4	Player Y pos
;	R5	Temp

_CHK_collision_map:
	PUSH BP
	MOV  BP, SP

;;
;; Store registers
;;
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5

;;
;; Initialize registers
;;
	mov  R0, [BP + 4]
	mov  R1, [R0 + 0]
	mov  R2, [R0 + 1]
	mov  R5, R1
	imul R5, R2
	iadd R0, R5
	iadd R0, 5
	mov  R3, [BP + 3]
	mov  R4, [BP + 2]

;;
;; Convert player position to tile position
;;
	idiv R3, 32
	idiv R4, 32

;;
;; Convert tile position to mem address
;;
	iadd R0, R3
	imul R4, R1
	iadd R0, R4

;;
;; Return the value at the mem address
;;
	mov  R5,     [R0]
	mov  [BP+4], R5

;;
;; Shift return address
;;
	mov   R0,     [BP+1] ;Save instruction for moving
	mov   [BP+3], R0     ;Move instruction to return point

;;
;; Restore registers
;;
	POP   R5
	POP   R4
	POP   R3
	POP   R2
	POP   R1
	POP   R0

;;
;; Return
;;
	POP  BP
	iadd SP, 2           ;Skip arguments
	ret
_OverworldInputsEnd:
