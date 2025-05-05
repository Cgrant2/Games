;
; Collisions: basic subroutines to handle collisions
;

	jmp  _end   ; avoid uncalled instructions

;===================================================;
;                    Basic Collision                ;
; Args: int X1min, int X1Max, int Y1min, int Y1Max, ;
;       int X2min, int X2Max, int Y2min, int Y2Max  ;
;                                                   ;
; Return bool: 0 if no collision, 1 if collision    ;
;===================================================;

_basiccol:
; Save everything we may need
	push BP
	mov  BP, SP
	push R0
	push R1
	push R2
; Arguments:
	;R0, BOOLEAN USE
	mov  R1, 0 ; RETURN VAL
	;[BP+9] ; X1min
	;[BP+8] ; X1Max
	;[BP+7] ; Y1min
	;[BP+6] ; Y1Max
	;[BP+5] ; X2min
	;[BP+4] ; X2Max
	;[BP+3] ; Y2min
	;[BP+2] ; Y2Max
; Logic:
	mov  R0, [BP+9] ;\
	mov  R2, [BP+4] ; \
	ile  R0, R2     ; | X1min is within bounds
	jf   R0, _bcret ;/

	mov  R0, [BP+8] ;\
	mov  R2, [BP+5] ; \
	ige  R0, R2     ; | X1Max is within bounds
	jf   R0, _bcret ;/

	mov  R0, [BP+7] ;\
	mov  R2, [BP+2] ; \
	ile  R0, R2     ; | Y1min is within bounds
	jf   R0, _bcret ;/

	mov  R0, [BP+6] ;\
	mov  R2, [BP+3] ; \
	ige  R0, R2     ; | Y1Max is within bounds
	jf   R0, _bcret ;/

	mov  R1, 1      ; Collision --> return 1
_bcret:
	mov  [BP+9], R1 ; move return value for pop
	mov  R0, [BP+1] ; \
	mov  [BP+8], R0 ; - move return address
	pop  R2
	pop  R1
	pop  R0
	mov  SP, BP
	pop  BP
	iadd SP, 7
	ret
_end:
