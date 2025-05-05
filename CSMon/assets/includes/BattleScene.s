	jmp  _BATTLEFILEEND
%define MULTCOLOR      GPU_MultiplyColor
%define GPUXSCALE      GPU_DrawingScaleX
%define GPUYSCALE      GPU_DrawingScaleY

%define BATCurs        R0
%define BATBool        R1
%define BATPlayAttack  R2
%define BATOppoAttack  R3
%define OppoProt       R4
%define PlayerProt     R5
%define PlayerAlive    R6
%define OppoAlive      R7
%define MenuID         R9
%define TEMP           R10

%define MonsterSize    0x11
%define PartySize      0x66
%define PlayerMonCNT   0x00000000
%define InBatPlayer    0x00000001
%define OpponentMonCNT 0x00000002
%define InBatOpponent  0x00000003
%define PlayerTeam     0x00001000
%define OpponentTeam   0x00001066
%define PlayerBag      0x00002000

;;
;; Usage
;; Push Name String
;; Push Thing String
;; Call _MonsterUsedThingDraw
;;
_MonsterUsedThingDraw:
	push BP
	mov  BP, SP

	push R0
	push R1
	push R2
	push R3
	in   R0, MULTCOLOR
	push R0
	out  MULTCOLOR, 0xFF000000

	mov  R0, [BP+3]
	push R0
	mov  R1, 10
	push R1
	mov  R2, 230
	push R2
	call _printMEM

	push R0
	call _stringLenMEM
	pop  R3

	imul R3, 10
	iadd R1, R3
	iadd R1, 10

	mov  R0, 0x0
	push R0
	mov  R0, 'd'
	push R0
	mov  R0, 'e'
	push R0
	mov  R0, 's'
	push R0
	mov  R0, 'u'
	push R0
	push R1
	push R2
	call _printS

	iadd R1, 50

	mov  R0, [BP+2]
	push R0
	push R1
	push R2
	call _printMEM

	out  MULTCOLOR, 0xFF0000FF
	mov  R0, 0x0
	push R0
	mov  R0, 'A'
	push R0
	mov  R0, ' '
	push R0
	mov  R0, 's'
	push R0
	mov  R0, 's'
	push R0
	mov  R0, 'e'
	push R0
	mov  R0, 'r'
	push R0
	mov  R0, 'p'
	push R0
	mov  R1, 10
	push R1
	mov  R2, 260
	push R2
	call _printS

	wait
	call _wait_for_A

	mov  R0, [BP+1]
	mov  [BP+3], R0
	pop  R0
	out  MULTCOLOR, R0
	pop  R3
	pop  R2
	pop  R1
	pop  R0
	pop  BP
	iadd SP, 2
	ret

;;
;; No stack manipulation needed
;;
_monsterMenuDraw:
	mov  TEMP, 4
	push TEMP
	mov  TEMP, 1
	push TEMP
	mov  TEMP, 473
	push TEMP
	mov  TEMP, 0
	push TEMP
	call _draw_region_at

	mov  TEMP, 4
	push TEMP
	mov  TEMP, 4
	push TEMP
	mov  TEMP, 501
	push TEMP
	mov  TEMP, BATCurs
	imul TEMP, 40
	iadd TEMP, 13
	push TEMP
	call _draw_region_at

	in   TEMP, MULTCOLOR
	push TEMP
	out  MULTCOLOR, 0xFF000000

	mov  TEMP, PlayerTeam
	push TEMP

__monsterMenuDrawLoop:
	mov  TEMP, [SP]
	push TEMP
	mov  TEMP, 521
	push TEMP
	mov  TEMP, [SP+1]
	isub TEMP, PlayerTeam
	idiv TEMP, MonsterSize
	imul TEMP, 40
	iadd TEMP, 10
	push TEMP
	call _printMEM

	mov  TEMP, [SP]
	iadd TEMP, MonsterSize
	mov  [SP], TEMP
	
	isub TEMP, PartySize
	ige  TEMP, PlayerTeam
	jf   TEMP, __monsterMenuDrawLoop

	pop  TEMP

	pop  TEMP
	out  MULTCOLOR, TEMP

	ret

_attackMenuDraw:
	mov  TEMP, 4
	push TEMP
	mov  TEMP, 1
	push TEMP
	mov  TEMP, 473
	push TEMP
	mov  TEMP, 0
	push TEMP
	call _draw_region_at

	in   TEMP, MULTCOLOR
	push TEMP
	out  MULTCOLOR, 0xFF000000

	mov  TEMP, [InBatPlayer]
	imul TEMP, MonsterSize
	iadd TEMP, PlayerTeam
	iadd TEMP, 14

	push TEMP	
	mov  TEMP, [TEMP]
	push TEMP	
	mov  TEMP, 521
	push TEMP
	mov  TEMP, 43
	push TEMP	
	call _printMEM

	pop  TEMP
	iadd TEMP, 1
	push TEMP	
	mov  TEMP, [TEMP]
	push TEMP	
	mov  TEMP, 521
	push TEMP
	mov  TEMP, 93
	push TEMP	
	call _printMEM

	pop  TEMP
	iadd TEMP, 1
	push TEMP	
	mov  TEMP, [TEMP]
	push TEMP	
	mov  TEMP, 521
	push TEMP
	mov  TEMP, 143
	push TEMP	
	call _printMEM
	pop  TEMP
	
	pop  TEMP
	out  MULTCOLOR, TEMP

	mov  TEMP, 4
	push TEMP
	mov  TEMP, 4
	push TEMP
	mov  TEMP, 501
	push TEMP
	mov  TEMP, BATCurs
	imul TEMP, 50
	iadd TEMP, 43
	push TEMP
	call _draw_region_at

	ret

_mainBatMenuDraw:
	mov  TEMP, 4
	push TEMP
	mov  TEMP, 0
	push TEMP
	mov  TEMP, 473
	push TEMP
	mov  TEMP, 0
	push TEMP
	call _draw_region_at

	mov  TEMP, 4
	push TEMP
	mov  TEMP, 4
	push TEMP
	mov  TEMP, 501
	push TEMP
	mov  TEMP, BATCurs
	imul TEMP, 50
	iadd TEMP, 43
	push TEMP
	call _draw_region_at

	ret
	
_renderBattle:
;;	Background
	mov  TEMP, 6
	push TEMP
	mov  TEMP, 0
	push TEMP
	push TEMP
	push TEMP
	call _draw_region_at

;;	Opponent platform
	mov  TEMP, 6
	push TEMP
	mov  TEMP, 1
	push TEMP
	mov  TEMP, 150
	push TEMP
	mov  TEMP, 120
	push TEMP
	call _draw_region_at

;;	Player platform
	mov  TEMP, 6
	push TEMP
	mov  TEMP, 2
	push TEMP
	mov  TEMP, 5
	push TEMP
	mov  TEMP, 359
	push TEMP
	call _draw_region_at

;;	Monster Scale
	out  GPUXSCALE, 2.5
	out  GPUYSCALE, 2.5

;;	Player monster
	mov  TEMP, 3
	push TEMP
	mov  TEMP, [InBatPlayer]
	imul TEMP, MonsterSize
	iadd TEMP, PlayerTeam
	iadd TEMP, 11
	mov  TEMP, [TEMP]
	push TEMP
	mov  TEMP, 140
	push TEMP
	mov  TEMP, 215
	push TEMP
	call _draw_region_zoomed_at

;;	Opponent monster
	mov  TEMP, 3
	push TEMP
	mov  TEMP, [InBatOpponent]
	imul TEMP, MonsterSize
	iadd TEMP, OpponentTeam
	iadd TEMP, 11
	mov  TEMP, [TEMP]
	iadd TEMP, 1
	push TEMP
	mov  TEMP, 180
	push TEMP
	mov  TEMP, 0
	push TEMP
	call _draw_region_zoomed_at

;;	Scale reset
	out  GPUXSCALE, 1.0
	out  GPUYSCALE, 1.0

;;	Set monster name color
	in   TEMP, MULTCOLOR
	push TEMP
	out  MULTCOLOR, 0xFF000000

;;	Opponent monster name
	mov  TEMP, [InBatOpponent]
	imul TEMP, MonsterSize
	iadd TEMP, OpponentTeam
	push TEMP
	mov  TEMP, 180
	push TEMP
	mov  TEMP, 10
	push TEMP
	call _printMEM

;;	Player monster name
	mov  TEMP, [InBatPlayer]
	imul TEMP, MonsterSize
	iadd TEMP, PlayerTeam
	push TEMP
	mov  TEMP, 370
	push TEMP
	mov  TEMP, 240
	push TEMP
	call _printMEM

	out  GPUXSCALE, 2.5
	out  GPUYSCALE, 2.5

;;	Set health color
	out  MULTCOLOR, 0xFF0000FF

;;	Opponent Health
	mov  TEMP, 0
	push TEMP
	mov  TEMP, 'p'
	push TEMP
	mov  TEMP, 'h'
	push TEMP
	mov  TEMP, [InBatOpponent]
	imul TEMP, MonsterSize
	iadd TEMP, OpponentTeam
	iadd TEMP, 13
	mov  TEMP, [TEMP]
	push TEMP
	mov  TEMP, 10
	push TEMP
	call _itoaS
	mov  TEMP, 180
	push TEMP
	mov  TEMP, 30
	push TEMP
	call _printS

;;	Player Health
	mov  TEMP, 0
	push TEMP
	mov  TEMP, 'p'
	push TEMP
	mov  TEMP, 'h'
	push TEMP
	mov  TEMP, [InBatPlayer]
	imul TEMP, MonsterSize
	iadd TEMP, PlayerTeam
	iadd TEMP, 13
	mov  TEMP, [TEMP]
	push TEMP
	mov  TEMP, 10
	push TEMP
	call _itoaS
	mov  TEMP, 370
	push TEMP
	mov  TEMP, 260
	push TEMP
	call _printS

	pop  TEMP
	out  MULTCOLOR, TEMP

	ret
	
	
	
	
;; Battle Scene handler
;; Basic strucure:
;;
;; Load opponent into RAM 
;; Battle start
;; Menus open
;; Do action
;; Check opponent alive
;; Opponent action
;; Check player alive
;; Loop to start if both active
;; Check opponent mons left
;; If opponent mons 0 end battle success
;; Check player mons left
;; If player mons 0 end battle failure


;; ASSUME OVW -> BATTLE transition has occured
_battleStart:
_batsavestack:
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
	;push R8
	push R9
	push R10
	push R11
	push R12
	push R13
	;in   R0, GPU_SelectedTexture
	;push R0
	;in   R0, GPU_SelectedRegion
	;push R0
	out  SPU_SelectedSound,        0
	out  SPU_SelectedChannel,      1
	out  SPU_ChannelAssignedSound, 0
	out  SPU_Command,              SPUCommand_PlaySelectedChannel

_battleLoad:
	mov  TEMP, 0
	mov  [InBatOpponent], TEMP

	mov  TEMP, [BP+2]
	ilt  TEMP, 16
	jt   TEMP, _battleLoadWild
	jf   TEMP, _battleLoadTeam
	
_battleLoadTeam:
	mov  OppoAlive, 1
	mov  TEMP, _DEX
	mov  BATBool, 14
	iadd TEMP, BATBool
	mov  TEMP, [TEMP]
	mov  CR, MonsterSize
	mov  SR, TEMP
	mov  DR, OpponentTeam
	movs
	jmp  _battleScene

_battleLoadWild:
	mov  OppoAlive, 1
	mov  TEMP, _DEX
	mov  BATBool, [BP+2]
	iadd TEMP, BATBool
	mov  TEMP, [TEMP]
	mov  CR, MonsterSize
	mov  SR, TEMP
	mov  DR, OpponentTeam
	movs
	jmp  _battleScene

_battleScene:
	;; R0 - BATCurs postition
	; Set player mon
	; Set opponent mon
	; Set menu main
	mov  BATCurs,         0    ;;Set cursor position 0
	mov  TEMP,            0
	mov  BATPlayAttack,   0
	mov  BATOppoAttack,   0
	mov  OppoProt,        0
	mov  PlayerProt,      0
	mov  PlayerAlive,     6
	mov  [InBatPlayer],   TEMP ;;Set players monster in battle
	mov  [InBatOpponent], TEMP ;;Set players monster in battle


_mainBatMenu:
	call _renderBattle
	call _mainBatMenuDraw
	wait
	; Move the cursor with d-pad input
	in   BATBool, INP_GamepadDown
	ieq  BATBool, 1
	iadd BATCurs, BATBool
	imod BATCurs, 4 
	in   BATBool, INP_GamepadUp
	ieq  BATBool, 1
	isub BATCurs, BATBool
	mov  BATBool, BATCurs
	ilt  BATBool, 0
	imul BATBool, 4
	iadd BATCurs, BATBool
	; move to selected submenu when A button pressed
	in   BATBool, INP_GamepadButtonA
	ieq  BATBool, 1
	mov  TEMP,    __menuAddrs
	iadd TEMP,    BATCurs
	mov  TEMP,    [TEMP]
	jt   BATBool, TEMP
	; No button pressed, return to top of loop
	jmp  _mainBatMenu

_attackBatMenu:
	call _renderBattle
	call _attackMenuDraw
	wait
	; Move the cursor with d-pad input
	in   BATBool, INP_GamepadDown
	ieq  BATBool, 1
	iadd BATCurs, BATBool
	imod BATCurs, 3 
	in   BATBool, INP_GamepadUp
	ieq  BATBool, 1
	isub BATCurs, BATBool
	mov  BATBool, BATCurs
	ilt  BATBool, 0
	imul BATBool, 3
	iadd BATCurs, BATBool
	; Return to main battle menu when B button is pressed
	in   BATBool, INP_GamepadButtonB
	ieq  BATBool, 1
	jt   BATBool, _mainBatMenu
	; Do selected attack when A Button is pressed
	in   BATBool, INP_GamepadButtonA
	ieq  BATBool, 1
	; Else loop until any button is pressed
	jf   BATBool, _attackBatMenu

_playerAttack:
	;Attack selected
	;;MON MEMADDR+14+Cursor in register defreferenced
	mov  BATBool, [InBatPlayer]
	imul BATBool, MonsterSize
	iadd BATBool, PlayerTeam
	iadd BATBool, BATCurs
	iadd BATBool, 14
	mov  BATPlayAttack, [BATBool]
	
	;;Register + 12 defreference = damage
	mov  BATBool, BATPlayAttack
	iadd BATBool, 12
	mov  BATBool, [BATBool]

	;;Register + 14 defreference = protflag
	mov  BATBool, BATPlayAttack
	iadd BATBool, 14
	mov  BATBool, [BATBool]

	;Accuracy check
	;;Register + 13 defreference = accuracy
	;;if random number < 100-accuracy : miss
	mov  BATBool, BATPlayAttack
	iadd BATBool, 13
	mov  TEMP,    [BATBool]
	mov  BATBool, 100
	isub BATBool, TEMP
	in   TEMP,    RNG_CurrentValue
	iabs TEMP
	imod TEMP,    100
	ilt  TEMP,    BATBool
	;If missed, skip to opponent logic
	jt   TEMP,    _oppoAttack

;;	Apply protection
	mov  TEMP, BATPlayAttack
	iadd TEMP, 14
	mov  TEMP, [TEMP]
	iadd PlayerProt, TEMP

	;Else, do the attack
	;; Multiply damage by type effectiveness : damage *= 2
	;;Register + 11 defreference = type

;;	Get attack type
	mov  BATBool, BATPlayAttack
	iadd BATBool, 11
	mov  TEMP, [BATBool]

;;	Get attack type table
	mov  BATBool, __TypeChart
	iadd TEMP, BATBool
	mov  TEMP, [TEMP]

;;	Get opponent type
	mov  BATBool, [InBatOpponent]
	imul BATBool, MonsterSize
	iadd BATBool, OpponentTeam
	iadd BATBool, 12
	mov  BATBool, [BATBool]


;;	Get the effectiveness of the attack
	iadd TEMP, BATBool
	mov  TEMP, [TEMP]

;;	Calculate attack damage
	mov  BATBool, BATPlayAttack
	iadd BATBool, 12
	mov  BATBool, [BATBool]
	imul BATBool, TEMP

;;	Wear down protection
	mov  TEMP, BATBool
	igt  TEMP,  0
	isub OppoProt, TEMP

;;	Zero damage if Opponent is protected
	mov  TEMP, OppoProt
	ilt  TEMP, 0
	imul BATBool, TEMP
	imax OppoProt, 0

;;	Deal damage
	mov  TEMP, [InBatOpponent]
	imul TEMP, MonsterSize
	iadd TEMP, OpponentTeam
	iadd TEMP, 13
	mov  TEMP, [TEMP]

	isub TEMP, BATBool
	imax TEMP, 0

	mov  BATBool, [InBatOpponent]
	imul BATBool, MonsterSize
	iadd BATBool, OpponentTeam
	iadd BATBool, 13
	mov  [BATBool], TEMP

;;	Display Text
	call _renderBattle

	mov  TEMP, [InBatPlayer]
	imul TEMP, MonsterSize
	iadd TEMP, PlayerTeam
	push TEMP
	push BATPlayAttack
	call _MonsterUsedThingDraw

;;	Die
	mov  TEMP, [InBatOpponent]
	imul TEMP, MonsterSize
	iadd TEMP, OpponentTeam
	iadd TEMP, 13
	mov  TEMP, [TEMP]
	ile  TEMP, 0
	isub OppoAlive, TEMP
	jf   OppoAlive, _battleEnd

_oppoAttack:
	;; select random attack
	in   TEMP,    RNG_CurrentValue
	iabs TEMP
	imod TEMP,    3

	mov  BATBool, [InBatOpponent]
	imul BATBool, MonsterSize
	iadd BATBool, OpponentTeam
	iadd BATBool, TEMP
	iadd BATBool, 14
	mov  BATOppoAttack, [BATBool]

	;Accuracy check
	;;Register + 13 defreference = accuracy
	;;if random number < 100-accuracy : miss
	mov  BATBool, BATOppoAttack
	iadd BATBool, 13
	mov  TEMP,    [BATBool]
	mov  BATBool, 100
	isub BATBool, TEMP
	in   TEMP,    RNG_CurrentValue
	iabs TEMP
	imod TEMP,    100
	ilt  TEMP,    BATBool
	;If missed, skip to opponent logic
	jt   TEMP,    _mainBatMenu

;;	Apply protection
	mov  TEMP, BATOppoAttack
	iadd TEMP, 14
	mov  TEMP, [TEMP]
	iadd OppoProt, TEMP

	;; if player protect flag is set, opponent damage *= 0
	;; if type supereffective damage *= 2

;;	Get attack type
	mov  BATBool, BATOppoAttack
	iadd BATBool, 11
	mov  TEMP, [BATBool]

;;	Get attack type table
	mov  BATBool, __TypeChart
	iadd TEMP, BATBool
	mov  TEMP, [TEMP]

;;	Get player type
	mov  BATBool, [InBatPlayer]
	imul BATBool, MonsterSize
	iadd BATBool, PlayerTeam
	iadd BATBool, 12
	mov  BATBool, [BATBool]

;;	Get the effectiveness of the attack
	iadd TEMP, BATBool
	mov  TEMP, [TEMP]

;;	Calculate attack damage
	mov  BATBool, BATOppoAttack
	iadd BATBool, 12
	mov  BATBool, [BATBool]
	imul BATBool, TEMP

;;	Wear down protection
	mov  TEMP, BATBool
	igt  TEMP, 0
	isub PlayerProt, TEMP

;;	Zero damage if Player is protected
	mov  TEMP, PlayerProt
	ilt  TEMP, 0
	imul BATBool, TEMP
	imax PlayerProt, 0

;;	Deal damage
	mov  TEMP, [InBatPlayer]
	imul TEMP, MonsterSize
	iadd TEMP, PlayerTeam
	iadd TEMP, 13
	mov  TEMP, [TEMP]

	isub TEMP, BATBool
	imax TEMP, 0

	mov  BATBool, [InBatPlayer]
	imul BATBool, MonsterSize
	iadd BATBool, PlayerTeam
	iadd BATBool, 13
	mov  [BATBool], TEMP

;;	Display Text
	call _renderBattle

	mov  TEMP, [InBatOpponent]
	imul TEMP, MonsterSize
	iadd TEMP, OpponentTeam
	push TEMP
	push BATOppoAttack
	call _MonsterUsedThingDraw

;;	Die
	mov  TEMP, [InBatPlayer]
	imul TEMP, MonsterSize
	iadd TEMP, PlayerTeam
	iadd TEMP, 13
	mov  TEMP, [TEMP]
	ile  TEMP, 0
	isub PlayerAlive, TEMP
	jf   PlayerAlive, _battleEnd

	jmp _mainBatMenu

_monBatMenu:
	call _renderBattle
	call _monsterMenuDraw
	wait
	mov  TEMP,    [PlayerMonCNT]
	; Move the cursor with d-pad input
	in   BATBool, INP_GamepadDown
	ieq  BATBool, 1
	iadd BATCurs, BATBool
	imod BATCurs, TEMP
	in   BATBool, INP_GamepadUp
	ieq  BATBool, 1
	isub BATCurs, BATBool
	mov  BATBool, BATCurs
	ilt  BATBool, 0
	imul BATBool, TEMP
	iadd BATCurs, BATBool
	; Return to main battle menu when B button is pressed
	in   BATBool, INP_GamepadButtonB
	ieq  BATBool, 1
	jt   BATBool, _mainBatMenu
	; Switch current Mon when A Button is pressed
	in   BATBool, INP_GamepadButtonA
	ieq  BATBool, 1
	; Else loop until a button is pressed
	jf   BATBool, _monBatMenu

_switchPlayerMon:
;;	Check if Mon is alive
	mov  BATBool, [BATCurs]
	imul BATBool, MonsterSize
	iadd BATBool, PlayerTeam
	iadd BATBool, 13
	ile  BATBool, 0
	jt   BATBool, _oppoAttack

	mov  [InBatPlayer], BATCurs
	jmp  _oppoAttack

_bagBatMenu:
	wait
	; Move the cursor with d-pad input
	in   BATBool, INP_GamepadDown
	ieq  BATBool, 1
	iadd BATCurs, BATBool
	imod BATCurs, 2 
	in   BATBool, INP_GamepadUp
	ieq  BATBool, 1
	isub BATCurs, BATBool
	mov  BATBool, BATCurs
	ilt  BATBool, 0
	imul BATBool, 2
	iadd BATCurs, BATBool
	; Return to main battle menu when B button is pressed
	in   BATBool, INP_GamepadButtonB
	ieq  BATBool, 1
	jt   BATBool, _mainBatMenu
	; Use selected item when A Button is pressed
	in   BATBool, INP_GamepadButtonA
	ieq  BATBool, 1
	; Else loop until a button is pressed
	jf   BATBool, _bagBatMenu

_useBatItem:
	;Item selected
	;If Ball and opponent is wild attempt catch
	;if succeed add to party
	;else jump to opponent logic 
	;If Potioni and has more than 1: heal current party member decrement potion
	;jump to opponent logic 

_runFromWild:
	wait
	; 90% chance to run from a battle if wild
	in   BATBool, RNG_CurrentValue
	imod BATBool, 100
	ilt  BATBool, 10
	jf   BATBool, _battleEnd
	jt   BATBool, _mainBatMenu
	;If true run failed, display text then jump back to mainBatManu
	;If false run worked, display text then exit battle

__menuAddrs:
	pointer _attackBatMenu, _mainBatMenu, _monBatMenu, _runFromWild, _mainBatMenu

_battleEnd:
	out  SPU_Command, SPUCommand_StopSelectedChannel
	mov  R0, [BP+1]
	mov  [BP+2], R0
	;pop  R0
	;out  GPU_SelectedTexture, R0
	;pop  R0
	;out  GPU_SelectedRegion, R0
	pop  R13
	pop  R12
	pop  R11
	pop  R10
	pop  R9
	;pop  R8
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

_BATTLEFILEEND:
