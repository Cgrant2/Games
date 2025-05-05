%ifndef DEBUG_ASM
%define DEBUG_ASM

jmp _DEBUG_FILE_END              ;Force skip if improperly included

%define  MULTICOLOR  GPU_MultiplyColor
%define  GPUTEXTURE  GPU_SelectedTexture
%define  GPUREGION   GPU_SelectedRegion
%define  XDRAWINGP   GPU_DrawingPointX
%define  YDRAWINGP   GPU_DrawingPointY
%define  GPUCOMMAND  GPU_Command
%define  DRAWREGION  GPUCommand_DrawRegion
%define  PADLEFT     INP_GamepadLeft
%define  PADRIGHT    INP_GamepadRight
%define  PADUP       INP_GamepadUp
%define  PADDOWN     INP_GamepadDown
%define  PADA        INP_GamepadButtonA
%define  PADB        INP_GamepadButtonB
%define  PADX        INP_GamepadButtonX
%define  PADY        INP_GamepadButtonY
%define  PADL        INP_GamepadButtonL
%define  PADR        INP_GamepadButtonR

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Hex print debug
;;;      Prints a raw hex value at pixel cordnitates
;;;
;;;   Usage:
;;;
;;;   Push value
;;;   Push Xpos
;;;   Push Ypos
;;;   Call _debug
;;;

;  R0    Value argument
;  R1    Print Xpos
;  R2    Print Ypos
;  R3    temp
_debugF:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store needed registers
;;
   PUSH  R0
   PUSH  R1
   PUSH  R2
   PUSH  R3

;;
;; Store GPU settings
;;
   in    R0,         MULTICOLOR
   PUSH  R0
   in    R0,         GPUTEXTURE
   PUSH  R0
   in    R0,         GPUREGION
   PUSH  R0
   in    R0,         XDRAWINGP
   PUSH  R0
   in    R0,         YDRAWINGP
   PUSH  R0

;;
;; Set GPU settings
;;
   mov   R0,         0xFFFFFFFF
   out   MULTICOLOR, R0
   mov   R0,         -1
   out   GPUTEXTURE, R0

;;
;; Main debug function
;;
   mov   R0,         [BP + 4]    ;VALUE
   mov   R1,         [BP + 3]    ;XPOS
   mov   R2,         [BP + 2]    ;YPOS
   out   YDRAWINGP,  R2

   mov   R3,         [BP + 1]    ;Old instruction pointer
   mov   [BP + 4],   R3          ;Move old instruction pointer

   mov   R3,         0           ;Null terminator for string
   push  R3

   mov   R3,         16          ;Base #

   push  R0                      ;Conver into string
   push  R3
   call  _itoaS

   mov   R3,         0x78        ;Add 'x'
   push  R3

   mov   R3,         0x30        ;Add '0'
   push  R3

   push  R1                      ;Print the string
   push  R2
   call  _printS

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
   POP   R0
   out   MULTICOLOR, R0

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
   mov   SP,         BP
   POP   BP
   iadd  SP,         3           ;Skip the arguments

   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Hex print debug
;;;      Prints a raw hex value at pixel cordnitates
;;;
;;;   Usage:
;;;
;;;   Push value
;;;   Push Xpos
;;;   Push Ypos
;;;   Call _debug
;;;

;  R0    Value argument
;  R1    Print Xpos
;  R2    Print Ypos
;  R3    Value/Char temp
;  R4    Index
;  R5    temp

_debug:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store all registers (not stack)
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
   PUSH  R13

;;
;; Store GPU settings
;;
   in    R0,         MULTICOLOR
   PUSH  R0
   in    R0,         GPUTEXTURE
   PUSH  R0
   in    R0,         GPUREGION
   PUSH  R0
   in    R0,         XDRAWINGP
   PUSH  R0
   in    R0,         YDRAWINGP
   PUSH  R0

;;
;; Set GPU settings
;;
   mov   R0,         0xFFFFFFFF
   out   MULTICOLOR, R0
   mov   R0,         -1
   out   GPUTEXTURE, R0

;;
;; Main debug function
;;
   mov   R0,         [BP + 4]    ;VALUE
   mov   R1,         [BP + 3]    ;XPOS
   mov   R2,         [BP + 2]    ;YPOS
   out   YDRAWINGP,  R2

   mov   R3,         [BP + 1]    ;Old instruction pointer
   mov   [BP + 4],   R3          ;Move old instruction pointer

   iadd  R1,         90          ;Print from the right

   mov   R4,         0           ;Current offset

__debug_printLoop:
   mov   R3,         R0          ;Char

   mov   R5,         R4          ;Get the bit offset
   imul  R5,         -4

   shl   R3,         R5          ;Get the current char into right most pos

   and   R3,         0x0000000F  ;Mask to a single char

   mov   R5,         R3          ;Check if char is a letter
   igt   R5,         9

   imul  R5,         7           ;digit - char offset

   iadd  R3,         R5          ;Apply letter offset
   iadd  R3,         0x30        ;Apply digit offset

   out   GPUREGION,  R3          ;Draw the digit
   out   XDRAWINGP,  R1
   out   GPUCOMMAND, DRAWREGION

   isub  R1,         10          ;Move left
   iadd  R4,         1           ;Next char

   mov   R5,         R4          ;Check if complete
   ige   R5,         8

   jt    R5,         __debug_printLoopFinish

   jmp   __debug_printLoop       ;Repeat

__debug_printLoopFinish:

   out   GPUREGION,  0x78        ;Draw the 'x'
   out   XDRAWINGP,  R1
   out   GPUCOMMAND, DRAWREGION

   isub  R1,         10          ;Move left

   out   GPUREGION,  0x30        ;Draw the '0'
   out   XDRAWINGP,  R1
   out   GPUCOMMAND, DRAWREGION

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
   POP   R0
   out   MULTICOLOR, R0

;;
;; Restore register
;;
   POP   R13
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
   mov   SP,         BP
   POP   BP
   iadd  SP,         3           ;Skip the arguments

   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Hex memory debug
;;;      Prints a list of mem values
;;;
;;;   Usage:
;;;
;;;   Push start value
;;;   Push end value
;;;   Call _debugmemory
;;;

;  R0    Start value
;  R1    End value
;  R2    Current value
;  R3    Xpos
;  R4    Ypos
;  R5    temp

_debugmemory:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store all registers (not stack)
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
   PUSH  R13

;;
;; Store GPU settings
;;
   in    R0,         MULTICOLOR
   PUSH  R0
   in    R0,         GPUTEXTURE
   PUSH  R0
   in    R0,         GPUREGION
   PUSH  R0
   in    R0,         XDRAWINGP
   PUSH  R0
   in    R0,         YDRAWINGP
   PUSH  R0

;;
;; Set GPU settings
;;
   mov   R0,         0xFFFFFFFF
   out   MULTICOLOR, R0
   mov   R0,         -1
   out   GPUTEXTURE, R0

;;
;; Main debug function
;;
   mov   R0,         [BP + 3]    ;Start
   mov   R1,         [BP + 2]    ;End

   mov   R5,         [BP + 1]    ;Old instruction pointer
   mov   [BP + 3],   R5          ;Move old instruction pointer

   mov   R2,         R0          ;Loop position
   mov   R4,         0           ;Start Y pos
   mov   R3,         0           ;Start X pos

__debugmemory_loop:
   mov   R5,         R2          ;Test if past final address
   igt   R5,         R1

   jt    R5,         __debugmemory_loopFinish

   out   YDRAWINGP,  R4          ;Set Y pos

   mov   R5,         0x5B        ;Draw the '['
   out   GPUREGION,  R5
   mov   R5,         R3
   iadd  R5,         0
   out   XDRAWINGP,  R5
   out   GPUCOMMAND, DRAWREGION

   mov   R5,         0x5D        ;Draw the ']'
   out   GPUREGION,  R5
   mov   R5,         R3
   iadd  R5,         110
   out   XDRAWINGP,  R5
   out   GPUCOMMAND, DRAWREGION

   mov   R5,         0x3A        ;Draw the ':'
   out   GPUREGION,  R5
   mov   R5,         R3
   iadd  R5,         120
   out   XDRAWINGP,  R5
   out   GPUCOMMAND, DRAWREGION

   push  R2                      ;Push the adress
   mov   R5,         R3          ;Xpos
   iadd  R5,         10
   push  R5
   push  R4                      ;Ypos
   call  _debug

   mov   R5,         [R2]        ;Get the value
   push  R5                      ;Push the value
   mov   R5,         R3          ;Xpos
   iadd  R5,         130
   push  R5
   push  R4                      ;Ypos
   call  _debug

   iadd  R4,         20          ;Move down
   mov   R5,         R4          ;Check to wrap
   igt   R5,         340
   jf    R5,         __debugmemory_wrap_skip

   mov   R4,         0
   iadd  R3,         235

__debugmemory_wrap_skip:
   iadd  R2,         1           ;Next address

   jmp   __debugmemory_loop

__debugmemory_loopFinish:

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
   POP   R0
   out   MULTICOLOR, R0

;;
;; Restore register
;;
   POP   R13
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
   mov   SP,         BP
   POP   BP
   iadd  SP,         2           ;Skip the arguments

   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Hex registers debug
;;;      Prints out all registers exept the stack
;;;
;;;   Usage:
;;;
;;;   Call _debugregs
;;;

;  R0    Xpos
;  R1    Ypos
;  R2    Iterator
;  R3    temp

_debugregs:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store all registers (not stack)
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
   PUSH  R13

;;
;; Add the stack pointers on for printing
;;
   mov   R0,         [BP]
   push  R0
   mov   R0,         BP
   iadd  R0,         2
   push  R0

;;
;; Store GPU settings
;;
   in    R0,         MULTICOLOR
   PUSH  R0
   in    R0,         GPUTEXTURE
   PUSH  R0
   in    R0,         GPUREGION
   PUSH  R0
   in    R0,         XDRAWINGP
   PUSH  R0
   in    R0,         YDRAWINGP
   PUSH  R0

;;
;; Set GPU settings
;;
   mov   R0,         0xFFFFFFFF
   out   MULTICOLOR, R0
   mov   R0,         -1
   out   GPUTEXTURE, R0

;;
;; Main debug function
;;
   mov   R0,         320         ;Starting Xpos
   mov   R1,         0           ;Starting Ypos
   mov   R2,         0           ;Base pointer offset

__debugregs_loop:
   mov   R3,         R2          ;End loop if past register 15
   igt   R3,         15
   jt    R3,         __debugregs_loop_end

   mov   R3,         0           ;Add the null terminator
   push  R3
   mov   R3,         0x3A        ;Add the ':'
   push  R3

   push  R2                      ;Convert the #
   mov   R3,         10          ;Base 10
   push  R3
   call  _itoaS

   mov   R3,         0x52        ;Add the 'R'
   push  R3

   push  R0
   push  R1
   call  _printS                 ;Print the label

   iadd  R2,         1           ;Go next index
   mov   R3,         BP          ;Get the register value from stack
   isub  R3,         R2
   mov   R3,         [R3]

   push  R3
   iadd  R0,         40
   push  R0
   push  R1
   call  _debug

   isub  R0,         40
   iadd  R1,         20
   jmp   __debugregs_loop

__debugregs_loop_end:

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
   POP   R0
   out   MULTICOLOR, R0

;;
;; Skip stack registers that were pushed
;;
   iadd  SP,         2

;;
;; Restore register
;;
   POP   R13
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

   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Frame wait timer
;;;      Waits for a given amount of frames
;;;
;;;   Usage:
;;;
;;;   Push frames
;;;   Call _wait_frames
;;;
_wait_frames:
   PUSH  BP
   MOV   BP,         SP

;;
;; Store registers
;;
   PUSH  R0

;;
;; Main frame wait function
;;
   mov   R0,         [BP + 2]
__wait_frames_loop:
   jf    R0,         __wait_frames_loop_end
   isub  R0,         1
   wait
   jmp   __wait_frames_loop
__wait_frames_loop_end:

   mov   R0,         [BP + 1]
   mov   [BP + 2],   R0

;;
;; Restore registers
;;
   POP   R0

;;
;; Return
;;
   POP   BP
   iadd  SP,         1
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Input wait interrupt
;;;      Waits until the player presses A/right, or B/left
;;;      A & right must be tapped, B & left may be held
;;;
;;;   Usage:
;;;
;;;   Call _input_wait
;;;
_input_wait:
   PUSH  BP
   MOV   BP,         SP
   PUSH  R0


;;
;; Main input wait function
;;
__input_wait_loop:
   in    R0,         PADLEFT
   igt   R0,         0
   jt    R0,         __input_wait_loop_end
   in    R0,         PADB
   igt   R0,         0
   jt    R0,         __input_wait_loop_end
   in    R0,         PADRIGHT
   ieq   R0,         1
   jt    R0,         __input_wait_loop_end
   in    R0,         PADA
   ieq   R0,         1
   jt    R0,         __input_wait_loop_end
   wait
   jmp   __input_wait_loop
__input_wait_loop_end:
   wait


;;
;; Return
;;
   POP   R0
   POP   BP
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Input wait interrupt
;;;      Waits until the player presses A
;;;
;;;   Usage:
;;;
;;;   Call _input_wait
;;;
_wait_for_A:
   PUSH  BP
   MOV   BP,         SP
   PUSH  R0


;;
;; Main input wait function
;;
__wait_for_A_loop:
   in    R0,         PADA
   ieq   R0,         1
   jt    R0,         __input_wait_loop_end
   wait
   jmp   __wait_for_A_loop
__wait_for_A_loop_end:
   wait


;;
;; Return
;;
   POP   R0
   POP   BP
   ret


%include "./print.s"
%include "./itoa.s"

_DEBUG_FILE_END:
%endif
