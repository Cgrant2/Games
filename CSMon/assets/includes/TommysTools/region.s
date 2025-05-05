%ifndef REGION_ASM
%define REGION_ASM

jmp _REGION_FILE_END          ;Force skip if improperly included

%define  GPUTEXTURE  GPU_SelectedTexture
%define  GPUREGION   GPU_SelectedRegion
%define  MINX        GPU_RegionMinX
%define  MAXX        GPU_RegionMaxX
%define  MINY        GPU_RegionMinY
%define  MAXY        GPU_RegionMaxY
%define  HOTSPOTX    GPU_RegionHotspotX
%define  HOTSPOTY    GPU_RegionHotspotY
%define  DRAWX       GPU_DrawingPointX
%define  DRAWY       GPU_DrawingPointY
%define  GPUCMD      GPU_Command
%define  GPUDRAW     GPUCommand_DrawRegion
%define  DRAWZOOMED  GPUCommand_DrawRegionZoomed

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   draw at
;;;      allows simple drawing of a region
;;;
;;;   Usage:
;;;
;;;   Push  X pos
;;;   Push  Y pos
;;;   Call _draw_at
;;;

;  R0    temp

_draw_at:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store registers
;;
   PUSH  R0

;;
;; Store GPU settings
;;
   IN    R0,         DRAWX
   PUSH  R0
   IN    R0,         DRAWY
   PUSH  R0

;;
;; Main draw function
;;
   mov   R0,         [BP + 3]    ;X pos
   out   DRAWX,      R0

   mov   R0,         [BP + 2]    ;Y pos
   out   DRAWY,      R0

   out   GPUCMD,     GPUDRAW     ;Draw the region

   mov   R0,         [BP + 1]    ;Save instruction for moving
   mov   [BP + 3],   R0          ;Move instruction to return point

;;
;; Restore GPU settings
;;
   POP   R0
   OUT   DRAWY,      R0
   POP   R0
   OUT   DRAWX,      R0

;;
;; Restore registers
;;
   POP   R0

;;
;; Return
;;
   POP   BP
   iadd  SP,         2        ;Skip arguments
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   draw region at
;;;      allows drawing of a region at a position
;;;
;;;   Usage:
;;;
;;;   Push  texture
;;;   Push  region
;;;   Push  X pos
;;;   Push  Y pos
;;;   Call _draw_region_at
;;;

;  R0    temp

_draw_region_at:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store registers
;;
   PUSH  R0

;;
;; Store GPU settings
;;
   IN    R0,         GPUTEXTURE
   PUSH  R0
   IN    R0,         GPUREGION
   PUSH  R0
   IN    R0,         DRAWX
   PUSH  R0
   IN    R0,         DRAWY
   PUSH  R0

;;
;; Main draw function
;;
   mov   R0,         [BP + 5] ;Selected texture
   out   GPUTEXTURE, R0

   mov   R0,         [BP + 4] ;Selected region
   out   GPUREGION,  R0

   mov   R0,         [BP + 3]    ;X pos
   out   DRAWX,      R0

   mov   R0,         [BP + 2]    ;Y pos
   out   DRAWY,      R0

   out   GPUCMD,     GPUDRAW     ;Draw the region

   mov   R0,         [BP + 1]    ;Save instruction for moving
   mov   [BP + 5],   R0          ;Move instruction to return point

;;
;; Restore GPU settings
;;
   POP   R0
   OUT   DRAWY,      R0
   POP   R0
   OUT   DRAWX,      R0
   POP   R0
   OUT   GPUREGION,  R0
   POP   R0
   OUT   GPUTEXTURE, R0

;;
;; Restore registers
;;
   POP   R0

;;
;; Return
;;
   POP   BP
   iadd  SP,         4        ;Skip arguments
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   draw region zoomed at
;;;      allows drawing of a region at a position at a set scale
;;;
;;;   Usage:
;;;
;;;   Push  texture
;;;   Push  region
;;;   Push  X pos
;;;   Push  Y pos
;;;   Call _draw_region_zoomed_at
;;;

;  R0    temp

_draw_region_zoomed_at:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store registers
;;
   PUSH  R0

;;
;; Store GPU settings
;;
   IN    R0,         GPUTEXTURE
   PUSH  R0
   IN    R0,         GPUREGION
   PUSH  R0
   IN    R0,         DRAWX
   PUSH  R0
   IN    R0,         DRAWY
   PUSH  R0

;;
;; Main draw function
;;
   mov   R0,         [BP + 5] ;Selected texture
   out   GPUTEXTURE, R0

   mov   R0,         [BP + 4] ;Selected region
   out   GPUREGION,  R0

   mov   R0,         [BP + 3]    ;X pos
   out   DRAWX,      R0

   mov   R0,         [BP + 2]    ;Y pos
   out   DRAWY,      R0

   out   GPUCMD,     DRAWZOOMED  ;Draw the region

   mov   R0,         [BP + 1]    ;Save instruction for moving
   mov   [BP + 5],   R0          ;Move instruction to return point

;;
;; Restore GPU settings
;;
   POP   R0
   OUT   DRAWY,      R0
   POP   R0
   OUT   DRAWX,      R0
   POP   R0
   OUT   GPUREGION,  R0
   POP   R0
   OUT   GPUTEXTURE, R0

;;
;; Restore registers
;;
   POP   R0

;;
;; Return
;;
   POP   BP
   iadd  SP,         4        ;Skip arguments
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   define full region
;;;      defines a region from scratch
;;;
;;;   Usage:
;;;
;;;   Push  texture
;;;   Push  region
;;;   Push  min x
;;;   Push  max x
;;;   Push  min y
;;;   Push  max y
;;;   Push  hotspot x
;;;   Push  hotspot y
;;;   Call _define_region
;;;

;  R0    temp

_define_region:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store registers
;;
   PUSH  R0

;;
;; Store GPU settings
;;
   IN    R0,         GPUTEXTURE
   PUSH  R0
   IN    R0,         GPUREGION
   PUSH  R0

;;
;; Main region function
;;
   mov   R0,         [BP + 9] ;Selected texture
   out   GPUTEXTURE, R0

   mov   R0,         [BP + 8] ;Selected region
   out   GPUREGION,  R0

   mov   R0,         [BP + 7] ;Y minimum
   out   MINX,       R0

   mov   R0,         [BP + 6] ;Y maximum
   out   MAXX,       R0

   mov   R0,         [BP + 5] ;Y minimum
   out   MINY,       R0

   mov   R0,         [BP + 4] ;Y maximum
   out   MAXY,       R0

   mov   R0,         [BP + 3] ;X hotspot
   out   HOTSPOTX,   R0

   mov   R0,         [BP + 2] ;Y hotspot
   out   HOTSPOTY,   R0

   mov   R0,         [BP + 1] ;Save instruction for moving
   mov   [BP + 9],   R0       ;Move instruction to return point

;;
;; Restore GPU settings
;;
   POP   R0
   OUT   GPUREGION,  R0
   POP   R0
   OUT   GPUTEXTURE, R0

;;
;; Restore registers
;;
   POP   R0

;;
;; Return
;;
   POP   BP
   iadd  SP,         8        ;Skip arguments
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   define region grid
;;;      defines many regions from scratch in a grid
;;;
;;;   Usage:
;;;
;;;   Push  texture
;;;   Push  starting region
;;;   Push  horizontal count
;;;   Push  vertical count
;;;   Push  starting x
;;;   Push  starting y
;;;   Push  width
;;;   Push  height
;;;   Push  hotspot offset x
;;;   Push  hotspot offset y
;;;   Call  _define_grid
;;;

;  R0    temp
;  R1    region counter
;  R2    x count max
;  R3    y count max
;  R4    width
;  R5    height
;  R6    xpos
;  R7    ypos
;  R8    starting xpos
;  R9    x hotspot offset
;  R10   y hotspot offset
;  R11   x counter
;  R12   y counter

_define_grid:
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
   PUSH  R10
   PUSH  R11
   PUSH  R12

;;
;; Store GPU settings
;;
   IN    R0,         GPUTEXTURE
   PUSH  R0
   IN    R0,         GPUREGION
   PUSH  R0

;;
;; Initialize registers
;;
   mov   R0,         [BP + 11]
   mov   R1,         [BP + 10]
   mov   R2,         [BP + 9]
   mov   R3,         [BP + 8]
   mov   R6,         [BP + 7]
   mov   R8,         R6
   mov   R7,         [BP + 6]
   mov   R4,         [BP + 5]
   mov   R5,         [BP + 4]
   mov   R9,         [BP + 3]
   mov   R10,        [BP + 2]
   mov   R11,        0
   mov   R12,        0

;;
;; Main region function
;;
   out   GPUTEXTURE, R0          ;Set texture used for all regions

   __define_gird_y_loop:

   mov   R11,        0           ;Reset x counter

   mov   R0,         R12         ;Check if past last row
   ige   R0,         R3
   jt    R0,         __define_gird_y_loop_end

   __define_gird_x_loop:

   mov   R0,         R11         ;Check if past last column
   ige   R0,         R2
   jt    R0,         __define_gird_x_loop_end

   out   GPUREGION,  R1          ;Select region

   out   MINX,       R6          ;Set minimums
   out   MINY,       R7

   mov   R0,         R6          ;Calc and set X hotspot
   iadd  R0,         R9
   out   HOTSPOTX,   R0

   mov   R0,         R7          ;Calc and set y hotspot
   iadd  R0,         R10
   out   HOTSPOTY,   R0

   iadd  R6,         R4          ;Calc the max x & y
   iadd  R7,         R5

   out   MAXX,       R6          ;Set the max x & y
   out   MAXY,       R7

   iadd  R6,         1           ;Go to the next region
   isub  R7,         R5
   iadd  R1,         1
   iadd  R11,        1

   jmp   __define_gird_x_loop

   __define_gird_x_loop_end:

   mov   R6,         R8          ;Go to the start of the next row
   iadd  R7,         R5
   iadd  R7,         1
   iadd  R12,        1

   jmp   __define_gird_y_loop

   __define_gird_y_loop_end:

   mov   R0,         [BP + 1] ;Save instruction for moving
   mov   [BP + 11],  R0       ;Move instruction to return point

;;
;; Restore GPU settings
;;
   POP   R0
   OUT   GPUREGION,  R0
   POP   R0
   OUT   GPUTEXTURE, R0

;;
;; Restore registers
;;
   POP   R12
   POP   R11
   POP   R10
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
   iadd  SP,         10       ;Skip arguments
   ret


_REGION_FILE_END:
%endif
