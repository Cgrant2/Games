%ifndef PRINT_ASM
%define PRINT_ASM

jmp _PRINT_FILE_END           ;Force skip if improperly included

%define  MULTICOLOR  GPU_MultiplyColor
%define  GPUTEXTURE  GPU_SelectedTexture
%define  GPUREGION   GPU_SelectedRegion
%define  XDRAWINGP   GPU_DrawingPointX
%define  YDRAWINGP   GPU_DrawingPointY
%define  GPUCOMMAND  GPU_Command
%define  DRAWREGION  GPUCommand_DrawRegion

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   print stack right justified
;;;      prints ascii text from the stack
;;;      warning: loops until it hits a null terminator
;;;
;;;   Usage:
;;;
;;;   *stack=string
;;;   Push Xpos
;;;   Push Ypos
;;;   Call _printSr
;;;

;  R0    Xpos
;  R1    Ypos
;  R2    char
;  R3    test

_printSr:

   PUSH  BP
   MOV   BP,         SP

;;
;; Store all needed registers
;;
   PUSH  R0
   PUSH  R1
   PUSH  R2
   PUSH  R3

;;
;; Store GPU settings
;;
   in    R0,         GPUTEXTURE
   PUSH  R0
   in    R0,         GPUREGION
   PUSH  R0
   in    R0,         XDRAWINGP
   PUSH  R0
   in    R0,         YDRAWINGP
   PUSH  R0

;;
;; Main print function
;;
   mov   R0,         [BP + 3] ;XPOS
   mov   R1,         [BP + 2] ;YPOS

   mov   SP,         BP       ;Start from before the call
   iadd  SP,         4

__printSr_null_search:
   mov   R3,         [SP]
   ieq   R3,         0
   jt    R3,         __printSr_null_found
   iadd  SP,         1
   jmp   __printSr_null_search

__printSr_null_found:
   mov   R3,         SP       ;Determine X offset
   isub  R3,         BP
   isub  R3,         5
   imul  R3,         10

   isub  R0,         R3       ;Shift X pos

   out   GPUTEXTURE, -1       ;Set texture
   out   YDRAWINGP,  R1       ;Set Y pos

   mov   SP,         BP       ;Start from before the call
   iadd  SP,         4

__printSr_loop:
   pop   R2
   mov   R3,         R2       ;Check if null terminator
   ieq   R3,         0
   jt    R3,         __printSr_loop_end

   out   GPUREGION,  R2       ;Draw the char
   out   XDRAWINGP,  R0
   out   GPUCOMMAND, DRAWREGION

   iadd  R0,         10       ;Shift X and loop
   jmp   __printSr_loop

__printSr_loop_end:

   mov   R0,         [BP + 1] ;Move return pointer
   push  R0

   mov   R0,         [BP]     ;Move old base pointer
   push  R0

   mov   R0,         [BP - 1] ;Move old registers
   push  R0
   mov   R0,         [BP - 2] ;Move old registers
   push  R0
   mov   R0,         [BP - 3] ;Move old registers
   push  R0
   mov   R0,         [BP - 4] ;Move old registers
   push  R0
   mov   R0,         [BP - 5] ;Move old settings
   push  R0
   mov   R0,         [BP - 6] ;Move old settings
   push  R0
   mov   R0,         [BP - 7] ;Move old settings
   push  R0
   mov   R0,         [BP - 8] ;Move old settings
   push  R0

;;
;; Restore GPU settings
;;
   POP   R0
   out   YDRAWINGP,  R0
   POP   R0
   out   XDRAWINGP,  R0
   POP   R0
   out   GPUREGION,  R0
   POP   R0
   out   GPUTEXTURE, R0

;;
;; Restore register
;;
   POP   R3
   POP   R2
   POP   R1
   POP   R0

;;
;; Return
;;
   POP   BP

   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   print stack
;;;      prints ascii text from the stack
;;;      warning: loops until it hits a null terminator
;;;
;;;   Usage:
;;;
;;;   *stack=string
;;;   Push Xpos
;;;   Push Ypos
;;;   Call _printS
;;;

;  R0    Xpos
;  R1    Ypos
;  R2    char
;  R3    test

_printS:

   PUSH  BP
   MOV   BP,         SP

;;
;; Store all needed registers
;;
   PUSH  R0
   PUSH  R1
   PUSH  R2
   PUSH  R3

;;
;; Store GPU settings
;;
   in    R0,         GPUTEXTURE
   PUSH  R0
   in    R0,         GPUREGION
   PUSH  R0
   in    R0,         XDRAWINGP
   PUSH  R0
   in    R0,         YDRAWINGP
   PUSH  R0

;;
;; Main print function
;;
   mov   R0,         [BP + 3] ;XPOS
   mov   R1,         [BP + 2] ;YPOS

   out   GPUTEXTURE, -1       ;Set texture
   out   YDRAWINGP,  R1       ;Set Y pos

   mov   SP,         BP       ;Start from before the call
   iadd  SP,         4

__printS_loop:
   pop   R2
   mov   R3,         R2       ;Check if null terminator
   ieq   R3,         0
   jt    R3,         __printS_loop_end

   out   GPUREGION,  R2       ;Draw the char
   out   XDRAWINGP,  R0
   out   GPUCOMMAND, DRAWREGION

   iadd  R0,         10       ;Shift X and loop
   jmp   __printS_loop

__printS_loop_end:

   mov   R0,         [BP + 1] ;Move return pointer
   push  R0

   mov   R0,         [BP]     ;Move old base pointer
   push  R0

   mov   R0,         [BP - 1] ;Move old registers
   push  R0
   mov   R0,         [BP - 2] ;Move old registers
   push  R0
   mov   R0,         [BP - 3] ;Move old registers
   push  R0
   mov   R0,         [BP - 4] ;Move old registers
   push  R0
   mov   R0,         [BP - 5] ;Move old settings
   push  R0
   mov   R0,         [BP - 6] ;Move old settings
   push  R0
   mov   R0,         [BP - 7] ;Move old settings
   push  R0
   mov   R0,         [BP - 8] ;Move old settings
   push  R0

;;
;; Restore GPU settings
;;
   POP   R0
   out   YDRAWINGP,  R0
   POP   R0
   out   XDRAWINGP,  R0
   POP   R0
   out   GPUREGION,  R0
   POP   R0
   out   GPUTEXTURE, R0

;;
;; Restore register
;;
   POP   R3
   POP   R2
   POP   R1
   POP   R0

;;
;; Return
;;
   POP   BP

   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   print memory
;;;      prints ascii text from memory
;;;      warning: loops until it hits a null terminator
;;;
;;;   Usage:
;;;
;;;   Push string address
;;;   Push Xpos
;;;   Push Ypos
;;;   Call _printMEM
;;;

;  R0    Address
;  R1    Xpos
;  R2    Ypos
;  R3    char
;  R4    test

_printMEM:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store all needed registers
;;
   PUSH  R0
   PUSH  R1
   PUSH  R2
   PUSH  R3
   PUSH  R4

;;
;; Store GPU settings
;;
   in    R0,         GPUTEXTURE
   PUSH  R0
   in    R0,         GPUREGION
   PUSH  R0
   in    R0,         XDRAWINGP
   PUSH  R0
   in    R0,         YDRAWINGP
   PUSH  R0

;;
;; Initialize data
;;
   mov   R0,         [BP + 4] ;ADDRESS
   mov   R1,         [BP + 3] ;XPOS
   mov   R2,         [BP + 2] ;YPOS

   out   GPUTEXTURE, 5        ;Set texture
   out   YDRAWINGP,  R2       ;Set Y pos
   jmp   __printMEM_loop

;;
;; Print loop
;;
__printMEM_newline:
   mov   R1,         [BP + 3] ;Move X pos
   iadd  R2,         20       ;Move Y pos
   out   YDRAWINGP,  R2       ;Set Y pos
   iadd  R0,         1        ;Next Char

__printMEM_loop:
   mov   R3,         [R0]     ;Get Char

   mov   R4,         R3       ;Text for newline
   ieq   R4,         0x0A
   jt    R4,         __printMEM_newline
   mov   R4,         R3
   ieq   R4,         0x0D
   jt    R4,         __printMEM_newline

   mov   R4,         R3       ;Test for null terminator
   ieq   R4,         0x00
   jt    R4,         __printMEM_loop_end

   out   GPUREGION,  R3       ;Draw the char
   out   XDRAWINGP,  R1
   out   GPUCOMMAND, DRAWREGION

   iadd  R1,         10       ;Move X pos
   iadd  R0,         1        ;Next Char
   jmp   __printMEM_loop

__printMEM_loop_end:
   mov   R0,         [BP + 1] ;Get instruction pointer
   mov   [BP + 4],   R0       ;Move instruction pointer

;;
;; Restore GPU settings
;;
   POP   R0
   out   YDRAWINGP,  R0
   POP   R0
   out   XDRAWINGP,  R0
   POP   R0
   out   GPUREGION,  R0
   POP   R0
   out   GPUTEXTURE, R0

;;
;; Restore register
;;
   POP   R4
   POP   R3
   POP   R2
   POP   R1
   POP   R0

;;
;; Return
;;
   POP   BP
   iadd  SP,         3
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   memory string length
;;;      gets the length of a string from
;;;      warning: loops until it hits a null terminator
;;;
;;;   Usage:
;;;
;;;   Push string address
;;;   Call _stringLenMEM
;;;   Pop  length
;;;

;  R0    Address
;  R1    Counter
;  R2    Test

_stringLenMEM:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store all needed registers
;;
   PUSH  R0
   PUSH  R1
   PUSH  R2

;;
;; Initialize data
;;
   mov   R0,         [BP + 2]
   mov   R1,         -1       ;Start at -1 to exlude terminator

__stringLenMEM_loop:
   iadd  R1,         1
   mov   R2,         [R0]
   iadd  R0,         1
   jt    R2,         __stringLenMEM_loop

   mov   [BP + 2],   R1

;;
;; Restore register
;;
   POP   R2
   POP   R1
   POP   R0

;;
;; Return
;;
   POP   BP

   ret

_PRINT_FILE_END:
%endif
