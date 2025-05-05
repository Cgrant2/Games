%ifndef OVERWORLDRENDER_ASM
%define OVERWORLDRENDER_ASM

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

;;;;;;;;;;;
; DEFINES ;
;;;;;;;;;;;

%ifndef TILEWIDTH
%define TILEWIDTH 32
%endif

%ifndef TILEHEIGHT
%define TILEHEIGHT 32
%endif

%ifndef SCREENWIDTH
%define SCREENWIDTH 640
%endif

%ifndef SCREENHEIGHT
%define SCREENHEIGHT 360
%endif

%ifndef CAMERAXOFFSET
%define CAMERAXOFFSET 304
%endif

%ifndef CAMERAYOFFSET
%define CAMERAYOFFSET 164
%endif

;;
;; Skip to end of file
;;
   jmp   _OVERWORLDRENDER_FILE_END


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   draw tile
;;;      draws a single tile given a region, map cordinates and camera position
;;;      NOTE: camera position is the top left pixel on screen
;;;
;;;   Usage:
;;;
;;;   Push  Tile map texture
;;;   Push  Tile region
;;;   Push  Map X cord
;;;   Push  Map Y cord
;;;   Push  Camera X pos
;;;   Push  Camera Y pos
;;;   Call _draw_tile
;;;

;  R0    Region
;  R1    Map X cord -> (projected X pos)
;  R2    Map Y cord -> (projected Y pos)
;  R3    Camera X pos
;  R4    Camera Y pos
;  R5    misc

_draw_tile:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store registers
;;
   PUSH  R0
   PUSH  R1
   PUSH  R2
   PUSH  R3
   PUSH  R4
   PUSH  R5

;;
;; Initialize registers
;;
   mov   R0,         [BP + 6]
   mov   R1,         [BP + 5]
   mov   R2,         [BP + 4]
   mov   R3,         [BP + 3]
   mov   R4,         [BP + 2]
   mov   R5,         0

;;
;; Main draw function
;;
   imul  R1,         TILEWIDTH   ;Convert map position to screen space
   imul  R2,         TILEHEIGHT

   isub  R1,         R3          ;Shift tile according to camera position
   isub  R2,         R4

;;
;; On screen check
;;
   mov   R5,         TILEWIDTH   ;Check if tile is left of the screen
   isgn  R5
   ige   R5,         R1
   jt    R5,         __draw_tile_skip

   mov   R5,         TILEHEIGHT  ;Check if tile is above the screen
   isgn  R5
   ige   R5,         R2
   jt    R5,         __draw_tile_skip

   mov   R5,         SCREENWIDTH ;Check if tile is right of the screen
   ile   R5,         R1
   jt    R5,         __draw_tile_skip

   mov   R5,         SCREENHEIGHT;Check if tile is below the screen
   ile   R5,         R2
   jt    R5,         __draw_tile_skip

;;
;; Tile draw call
;;
   mov   R5,         [BP + 7]    ;Get the texture used for the tilemap
   push  R5                      ;Add texture to draw call
   push  R0                      ;Add region to draw call
   push  R1                      ;Add X pos to draw call
   push  R2                      ;Add Y pos to draw call
   call  _draw_region_at         ;Draw the tile

__draw_tile_skip:
   mov   R0,         [BP + 1] ;Save instruction for moving
   mov   [BP + 7],   R0       ;Move instruction to return point

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
   POP   BP
   iadd  SP,         6        ;Skip arguments
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   draw tile map
;;;      draws the tile map given the map dimensions and player position
;;;
;;;   Usage:
;;;
;;;   Push  Tile map (mem address)
;;;   Push  Player X cord
;;;   Push  Player Y cord
;;;   Call _draw_tile_map
;;;

;  R0    Mem address
;  R1    Map width
;  R2    Map height
;  R3    Player X pos
;  R4    Player Y pos
;  R5    Map x counter
;  R6    Map y counter
;  R7    misc
;  R8    Y loop max
;  R9    X loop max

_draw_tile_map:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store registers
;;
   PUSH  R0
   PUSH  R1
   PUSH  R2
   PUSH  R3
   PUSH  R4
   PUSH  R5
   PUSH  R6
   PUSH  R7
   PUSH  R8
   PUSH  R9

;;
;; Initialize registers
;;
   mov   R0,         [BP + 4]
   mov   R1,         [R0]
   mov   R2,         [R0 + 1]
   iadd  R0,         3
   mov   R3,         [BP + 3]
   isub  R3,         CAMERAXOFFSET
   mov   R4,         [BP + 2]
   isub  R4,         CAMERAYOFFSET
   mov   R5,         0
   mov   R6,         0
   mov   R7,         0

;;
;; Limit camera to the map size
;;
   imax  R3,         0        ;Limit the minimum to 0
   imax  R4,         0

   mov   R7,         R1       ;Limit the maximum to the map width - screensize
   imul  R7,         TILEWIDTH
   isub  R7,         SCREENWIDTH
   imin  R3,         R7

   mov   R7,         R2       ;Limit the maximum to the map height - screensize
   imul  R7,         TILEHEIGHT
   isub  R7,         SCREENHEIGHT
   imin  R4,         R7

;;
;; Set data for loops
;;
   mov   R6,         R4       ;Start just above the screen
   idiv  R6,         TILEHEIGHT

   mov   R7,         R1       ;Adjust the address for y offset
   imul  R7,         R6
   iadd  R0,         R7


   mov   R7,         R3       ;Adjust the address for x offset
   idiv  R7,         TILEWIDTH
   iadd  R0,         R7

   mov   R8,         R7       ;Adjust loop end point for x
   mov   R7,         SCREENWIDTH
   idiv  R7,         TILEWIDTH
   iadd  R8,         R7
   iadd  R8,         1        ;Overdraw 1 tile

   mov   R9,         R2       ;Adjust loop end point for y
   mov   R9,         R6
   mov   R7,         SCREENHEIGHT
   idiv  R7,         TILEHEIGHT
   iadd  R9,         R7
   iadd  R9,         2        ;Overdraw 2 tiles (screen height is not perfect)

;;
;; Main draw Y loop
;;
__draw_tile_map_Yloop:
   mov   R7,         R6       ;Test if past last row of map
   ige   R7,         R9
   jt    R7,         __draw_tile_map_Yloop_end

;;
;; Set data for X loop
;;
   mov   R5,         R3       ;Start just left of screen
   idiv  R5,         TILEWIDTH

;;
;; Main draw X loop
;;
__draw_tile_map_Xloop:
   mov   R7,         R5       ;Test if past last column of map
   ige   R7,         R8
   jt    R7,         __draw_tile_map_Xloop_end

;;
;; Draw the tile
;;
   mov   R7,         [BP + 4] ;Get the tile map texture
   mov   R7,         [R7 + 2]
   push  R7                   ;Add tile map texture to call
   mov   R7,         [R0]     ;Get the tile region
   push  R7                   ;Add region to call
   push  R5                   ;Add map x cord to call
   push  R6                   ;Add map y cord to call
   push  R3                   ;Add player x pos to call
   push  R4                   ;Add player y pos to call
   call  _draw_tile           ;Draw the tile on the screen

;;
;; Adjust data for loop
;;
   iadd  R0,         1        ;Go to next tile address
   iadd  R5,         1        ;Go to next tile x cord

   jmp   __draw_tile_map_Xloop

__draw_tile_map_Xloop_end:
;;
;; Adjust data for loop
;;
   iadd  R6,         1        ;Go to next tile y cord

   iadd  R0,         R1       ;Skip the undrawn tiles
   mov   R7,         SCREENWIDTH
   idiv  R7,         TILEWIDTH
   isub  R0,         R7
   isub  R0,         1

   jmp   __draw_tile_map_Yloop

__draw_tile_map_Yloop_end:
   mov   R0,         [BP + 1] ;Save instruction for moving
   mov   [BP + 4],   R0       ;Move instruction to return point

;;
;; Initialize registers to draw player
;;
   mov   R0,         0
   mov   R1,         [BP + 3]
   idiv  R1,         32
   mov   R2,         [BP + 2]
   idiv  R2,         32
   in    R5,         INP_LEFT
   in    R6,         INP_RIGHT
   in    R7,         INP_UP
   in    R8,         INP_DOWN

;;
;; Draw the player based on the input
;;
   push  R0                   ;Add the texture

   imax  R5,         0
   jt    R5,         __draw_tile_map_left
   imax  R6,         0
   jt    R6,         __draw_tile_map_right
   imax  R7,         0
   jt    R7,         __draw_tile_map_up
   imax  R8,         0
   jt    R8,         __draw_tile_map_down
   jmp   __draw_tile_map_player

__draw_tile_map_left:
   mov   R0,         R5       ;Get the time holding the button
   idiv  R0,         5        ;Slow the cycle down
   imod  R0,         3        ;Limit the cycle to the 3 frames
   iadd  R0,         3        ;Add the direction offset
   jmp   __draw_tile_map_player
__draw_tile_map_right:
   mov   R0,         R6       ;Get the time holding the button
   idiv  R0,         5        ;Slow the cycle down
   imod  R0,         3        ;Limit the cycle to the 3 frames
   iadd  R0,         9        ;Add the direction offset
   jmp   __draw_tile_map_player
__draw_tile_map_up:
   mov   R0,         R7       ;Get the time holding the button
   idiv  R0,         5        ;Slow the cycle down
   imod  R0,         3        ;Limit the cycle to the 3 frames
   iadd  R0,         6        ;Add the direction offset
   jmp   __draw_tile_map_player
__draw_tile_map_down:
   mov   R0,         R8       ;Get the time holding the button
   idiv  R0,         5        ;Slow the cycle down
   imod  R0,         3        ;Limit the cycle to the 3 frames
   jmp   __draw_tile_map_player
__draw_tile_map_player:
   push  R0                   ;Animation frame
   push  R1                   ;Tile X
   push  R2                   ;Tile Y
   push  R3                   ;Camera X
   push  R4                   ;Camera Y
   call  _draw_tile
   
;;
;; Restore registers
;;
   POP   R9
   POP   R8
   POP   R7
   POP   R6
   POP   R5
   POP   R4
   POP   R3
   POP   R2
   POP   R1
   POP   R0

;;
;; Return
;;
   POP   BP
   iadd  SP,         3        ;Skip arguments
   ret


%include "TommysTools/region.s"

_OVERWORLDRENDER_FILE_END:
%endif
