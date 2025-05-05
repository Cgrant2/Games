%ifndef ITOA_ASM
%define ITOA_ASM

jmp _ITOA_FILE_END              ;Force skip if improperly included

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
;;;   itoa
;;;      convert int to ascii of any base (2-16)
;;;      returns into a memory string
;;;
;;;   Usage:
;;;
;;;   Push value
;;;   Push base
;;;   Push string start
;;;   Call _itoa
;;;

;  R0    Value
;  R1    Base #
;  R2    String position
;  R3    Add value
;  R4    table string
;  R5    temp1
;  R6    temp2
_itoa:
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
   PUSH  R5
   PUSH  R6

;;
;; Main itoa function
;;
   mov   R0,         [BP + 4]    ;VALUE
   mov   R1,         [BP + 3]    ;BASE
   mov   R2,         [BP + 2]    ;STRING

   mov   R3,         [BP + 1]    ;Old instruction pointer
   mov   [BP + 4],   R3          ;Move old instruction pointer

   mov   R5,         R1          ;Check if base under min base
   ilt   R5,         2
   jt    R5,         __itoa_return
   mov   R5,         R1          ;Check if base over max base
   igt   R5,         16
   jt    R5,         __itoa_return

   mov   R6,         0           ;Push "null terminator"
   push  R6

   mov   R6,         R0          ;Check if value is negative
   ilt   R6,         0
   jt    R6,         __itoa_if_neg_true
   jf    R6,         __itoa_if_neg_false

__itoa_if_neg_true:
   mov   R6,         R1          ;Check if base is ten
   ieq   R6,         10
   jt    R6,         __itoa_if_b10_true
   jf    R6,         __itoa_if_b10_false

__itoa_if_b10_true:
   mov   R5,         0x2D
   mov   [R2],       R5          ;Add negative sign to string
   iadd  R2,         1           ;Go next char
   imul  R0,         -1          ;Convert to pos
   jmp   __itoa_if_b10_end

__itoa_if_b10_false:
   isub  R0,         0x80000000  ;"Shift" value down
   mov   R3,         0x40000000  ;Add value is half of "shifted"
   jmp   __itoa_if_b10_end

__itoa_if_b10_end:
   jmp   __itoa_if_neg_end

__itoa_if_neg_false:
   jmp   __itoa_if_neg_end

__itoa_if_neg_end:
   mov   R5,         0
   mov   R6,         0

;;
;; Conversion loop
;;
__itoa_loop:
   mov   R6,         R0          ;Get the remainder of the value
   imod  R6,         R1
   iadd  R5,         R6          ;Add the remainder to the working value
   mov   R6,         R3          ;Get twice the remainder of the add value
   imod  R6,         R1
   imul  R6,         2
   iadd  R5,         R6          ;Add the remainder to the working value

   mov   R6,         R5          ;Get the remainder of the working value
   imod  R6,         R1

   mov   R4,         __itoa_convert_table
   iadd  R4,         R6
   mov   R6,         [R4]
   push  R6

   idiv  R5,         R1          ;Carry the extra working value

   idiv  R0,         R1          ;Divide value by base #
   idiv  R3,         R1          ;Divide add value by base #

   jt    R0,         __itoa_loop ;Repeat if any values are non zero
   jt    R3,         __itoa_loop
   jt    R5,         __itoa_loop


;;
;; Moves string from stack to memory
;;
__itoa_string_loop:
   pop   R6                      ;Get the current char
   mov   R5,         R6          ;End if null
   ieq   R5,         0
   jt    R5,         __itoa_string_loop_end

   mov   [R2],       R6          ;Add char
   iadd  R2,         1           ;Go next char
   jmp   __itoa_string_loop

__itoa_string_loop_end:

   mov   R5,         0
   mov   [R2],       R5          ;Add null terminator

__itoa_return:

;;
;; Restore register
;;
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
;;;   itoa stack
;;;      convert int to ascii of any base (2-16)
;;;      returns into the stack
;;;      *NOTE: does not add the null terminator
;;;
;;;   Usage:
;;;
;;;   *Push null terminator (optional)
;;;   Push value
;;;   Push base
;;;   Call _itoaS
;;;

;  R0    Value
;  R1    Base #
;  R2    negative flag
;  R3    Add value
;  R4    table string
;  R5    temp1
;  R6    temp2
;  R7    stack temp
_itoaS:
   isub  SP,         31          ;Leave room for string + and return data

;;
;; Store all needed registers
;;
   PUSH  BP
   PUSH  R0
   PUSH  R1
   PUSH  R2
   PUSH  R3
   PUSH  R4
   PUSH  R5
   PUSH  R6
   PUSH  R7

;;
;; Move to the start of the stack
;;
   MOV   BP,         SP
   iadd  BP,         43
   mov   SP,         BP


;;
;; Main itoa string function
;;
   mov   R0,         [BP - 1]    ;VALUE
   mov   R1,         [BP - 2]    ;BASE
   mov   R7,         [BP - 3]    ;Instruction pointer

   mov   R5,         R1          ;Check if base under min base
   ilt   R5,         2
   jt    R5,         __itoaS_return
   mov   R5,         R1          ;Check if base over max base
   igt   R5,         16
   jt    R5,         __itoaS_return

   mov   R3,         0           ;Add value is set to zero

   mov   R6,         R0          ;Check if value is negative
   ilt   R6,         0
   jt    R6,         __itoaS_if_neg_true
   jf    R6,         __itoaS_if_neg_false

__itoaS_if_neg_true:
   mov   R6,         R1          ;Check if base is ten
   ieq   R6,         10
   jt    R6,         __itoaS_if_b10_true
   jf    R6,         __itoaS_if_b10_false

__itoaS_if_b10_true:
   mov   R2,         1           ;Set negative flag true
   imul  R0,         -1
   jmp   __itoaS_if_b10_end

__itoaS_if_b10_false:
   mov   R2,         0           ;Set negative flag false
   isub  R0,         0x80000000  ;"Shift" value down
   mov   R3,         0x40000000  ;Add value is half of "shifted"
   jmp   __itoaS_if_b10_end

__itoaS_if_b10_end:
   jmp   __itoaS_if_neg_end

__itoaS_if_neg_false:
   mov   R2,         0           ;Set negative flag false
   jmp   __itoaS_if_neg_end

__itoaS_if_neg_end:

   mov   R5,         0
   mov   R6,         0

;;
;; Conversion loop
;;
__itoaS_loop:
   mov   R6,         R0          ;Get the remainder of the value
   imod  R6,         R1
   iadd  R5,         R6          ;Add the remainder to the working value
   mov   R6,         R3          ;Get twice the remainder of the add value
   imod  R6,         R1
   imul  R6,         2
   iadd  R5,         R6          ;Add the remainder to the working value

   mov   R6,         R5          ;Get the remainder of the working value
   imod  R6,         R1

   mov   R4,         __itoa_convert_table
   iadd  R4,         R6
   mov   R6,         [R4]
   push  R6

   idiv  R5,         R1          ;Carry the extra working value

   idiv  R0,         R1          ;Divide value by base #
   idiv  R3,         R1          ;Divide add value by base #

   jt    R0,         __itoaS_loop ;Repeat if any values are non zero
   jt    R3,         __itoaS_loop
   jt    R5,         __itoaS_loop

__itoaS_loop_end:


   jt    R2,         __itoaS_if_negFlag_true
   jf    R2,         __itoaS_if_negFlag_false

__itoaS_if_negFlag_true:
   mov   R2,         0x2D        ;Add negative sign
   push  R2
   jmp __itoaS_if_negFlag_end

__itoaS_if_negFlag_false:
   jmp __itoaS_if_negFlag_end

__itoaS_if_negFlag_end:


__itoaS_return:

   push  R7                      ;Add return value after string
   mov   [BP - 34],  SP          ;Add adress to return from to data clump
   mov   SP,         BP          ;Go to data clump
   isub  SP,         43

;;
;; Restore register
;;
   POP   R7
   POP   R6
   POP   R5
   POP   R4
   POP   R3
   POP   R2
   POP   R1
   POP   R0
   POP   BP

;;
;; Return
;;
   POP   SP
   isub  SP,         1           ;Offset because POP changes SP after popping
   ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   base 2-16 ascii conversion table
;;;
__itoa_convert_table:
    string "0123456789ABCDEF"

_ITOA_FILE_END:
%endif
