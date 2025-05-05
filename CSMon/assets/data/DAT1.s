	jmp     _DAT1END
; ROM for Mon/Attack templates:

;__MONTEMPLATE:
;	string  "NAME     "  ; 10 chars + null, unused replaced with Null terminator
;	integer SPRITEREGION ; Location of the Sprites
;	integer TYPE         ; what type the mon is, 0-Normal, 1-Grass ...
;   integer HEALTH       ; How much max health the mon has
;	pointer Attack1      ; Pointer to an attack
;	pointer Attack2      ; Pointer to an attack
;	pointer Attack3      ; Pointer to an attack
;   TOTAL                ; 17 words

_DEX:
	pointer __Turtwig, __Piplup, __Chimchar, __Bidoof, __Shinx, __Pidove, __Venipede, __Riolu, __Wooper, __Voltorb, __Eevee, __Seedot, __Magnemite, __Porygon, __Mudkip

__Turtwig:
	string  "Turtwig\x00\x00\x00"     ; 10 Chars + null
	integer 0                 ; Sprite Region
	integer 1                 ; Type
	integer 250               ; Health
	pointer __tackle
	pointer __protect
	pointer __vine_whip

__Piplup:
	string  "Piplup\x00\x00\x00\x00"  ; 10 Chars + null
	integer 4                 ; Sprite Region
	integer 2                 ; Type
	integer 250               ; Health
	pointer __tackle
	pointer __protect
	pointer __water_gun
__Chimchar:
	string  "Chimchar\x00\x00"    ; 10 Chars + null
	integer 2                 ; Sprite Region
	integer 3                 ; Type
	integer 250               ; Health
	pointer __tackle
	pointer __protect
	pointer __ember
__Bidoof:
	string  "Bidoof\x00\x00\x00\x00"  ; 10 Chars + null
	integer 6                 ; Sprite Region
	integer 0                 ; Type
	integer 175               ; Health
	pointer __tackle
	pointer __protect
	pointer __water_gun
__Shinx:
	string  "Shinx\x00\x00\x00\x00\x00" ; 10 Chars + null
	integer 8                 ; Sprite Region
	integer 4                 ; Type
	integer 175               ; Health
	pointer __tackle
	pointer __protect
	pointer __shock
__Pidove:
	string  "Pidove\x00\x00\x00\x00"  ; 10 Chars + null
	integer 10                ; Sprite Region
	integer 5                 ; Type
	integer 175               ; Health
	pointer __tackle
	pointer __protect
	pointer __peck
__Venipede:
	string  "Venipede\x00\x00"    ; 10 Chars + null
	integer 12                ; Sprite Region
	integer 6                 ; Type
	integer 150               ; Health
	pointer __tackle
	pointer __protect
	pointer __bug_bite
__Riolu:
	string  "Riolu\x00\x00\x00\x00\x00" ; 10 Chars + null
	integer 14                ; Sprite Region
	integer 7                 ; Type
	integer 225               ; Health
	pointer __tackle
	pointer __protect
	pointer __aura_blast
__Wooper:
	string  "Wooper\x00\x00\x00\x00"  ; 10 Chars + null
	integer 16                ; Sprite Region
	integer 2                 ; Type
	integer 200               ; Health
	pointer __mud_shot
	pointer __protect
	pointer __water_gun
__Voltorb:
	string  "Voltorb\x00\x00\x00"   ; 10 Chars + null
	integer 18                ; Sprite Region
	integer 4                 ; Type
	integer 250               ; Health
	pointer __tackle
	pointer __protect
	pointer __shock
__Eevee:
	string  "Eevee\x00\x00\x00\x00\x00" ; 10 Chars + null
	integer 20                ; Sprite Region
	integer 0                 ; Type
	integer 200               ; Health
	pointer __water_gun
	pointer __ember
	pointer __vine_whip
__Seedot:
	string  "Seedot\x00\x00\x00\x00"  ; 10 Chars + null
	integer 22                ; Sprite Region
	integer 1                 ; Type
	integer 250               ; Health
	pointer __tackle
	pointer __protect
	pointer __vine_whip
__Magnemite:
	string  "Magnemite\x00"     ; 10 Chars + null
	integer 24                ; Sprite Region
	integer 4                 ; Type
	integer 300               ; Health
	pointer __tackle
	pointer __protect
	pointer __shock
__Porygon:
	string  "Porygon\x00\x00\x00"   ; 10 Chars + null
	integer 26                ; Sprite Region
	integer 0                 ; Type
	integer 350               ; Health
	pointer __tackle
	pointer __protect
	pointer __shock
__Mudkip:
	string  "Mudkip\x00\x00\x00\x00"  ; 10 Chars + null
	integer 28                ; Sprite Region
	integer 2                 ; Type
	integer 400               ; Health
	pointer __hydro_pump
	pointer __protect
	pointer __earthquake

;__ATTACKTEMPLATE:
;	string  "NAME     "  ; 9 chars, unused replaced with Null terminator
;	integer TYPE         ; what type the attack is, 0-Normal, 1-Grass ...
;	integer POWER        ; Damage of the attack
;	integer ACCURACY     ; Percent chance the attack will hit
;   integer PROTFLAG     ; Used by protect, sets protect flag

__Attacks:
	pointer __tackle, __water_gun, __ember, __vine_whip, __mud_shot, __peck, __bug_bite, __shock, __aura_blast, __protect, __earthquake, __hydro_pump
__tackle:
	string  "Tackle\x00\x00\x00\x00"  ; 10 chars + null
	integer 0                 ; Type: Normal
	integer 50                ; Damage
	integer 100               ; Percent chance the attack will hit
	integer 0                 ; ProtFlag
__water_gun:
	string  "Water Gun\x00"     ; 10 chars + null
	integer 2                 ; Type: Water
	integer 50                ; Damage
	integer 95                ; Percent chance the attack will hit
	integer 0                 ; ProtFlag
__ember:
	string  "Ember\x00\x00\x00\x00\x00" ; 10 chars + null
	integer 3                 ; Type: Fire
	integer 50                ; Damage
	integer 95                ; Percent chance the attack will hit
	integer 0                 ; ProtFlag
__vine_whip:
	string  "Vine Whip\x00"     ; 10 chars + null
	integer 1                 ; Type: Grass
	integer 50                ; Damage
	integer 95                ; Percent chance the attack will hit
	integer 0                 ; ProtFlag
__mud_shot:
	string  "Mud Shot\x00\x00"  ; 10 chars + null
	integer 8                 ; Type: Ground
	integer 50                ; Damage
	integer 95                ; Percent chance the attack will hit
	integer 0                 ; ProtFlag
__peck:
	string  "Peck\x00\x00\x00\x00\x00\x00"; 10 chars + null
	integer 5                 ; Type: Flying
	integer 50                ; Damage
	integer 95                ; Percent chance the attack will hit
	integer 0                 ; ProtFlag
__bug_bite:
	string  "Bug Bite\x00\x00"     ; 10 chars + null
	integer 6                 ; Type: Bug
	integer 50                ; Damage
	integer 95                ; Percent chance the attack will hit
	integer 0                 ; ProtFlag
__shock:
	string  "Shock\x00\x00\x00\x00\x00" ; 10 chars + null
	integer 4                 ; Type: Electric
	integer 50                ; Damage
	integer 95                ; Percent chance the attack will hit
	integer 0                 ; ProtFlag
__aura_blast:
	string  "Aura Blast"      ; 10 chars + null
	integer 7                 ; Type: Fighting
	integer 75                ; Damage
	integer 90                ; Percent chance the attack will hit
	integer 0                 ; ProtFlag
__protect:
	string  "Protect\x00\x00\x00"   ; 10 chars + null
	integer 0                 ; Type: Normal
	integer 0                 ; Damage
	integer 100               ; Percent chance the attack will hit
	integer 1                 ; ProtFlag
__earthquake:
	string  "Earthquake"      ; 10 chars + null
	integer 8                 ; Type: Ground
	integer 125               ; Damage
	integer 80                ; Percent chance the attack will hit
	integer 0                 ; ProtFlag
__hydro_pump:
	string  "Hydro Pump"      ; 10 chars + null
	integer 2                 ; Type: Water
	integer 125               ; Damage
	integer 80                ; Percent chance the attack will hit
	integer 0                 ; ProtFlag

__TypeChart:
	pointer __normal, __grass, __water, __fire, __electric, __flying, __bug, __fighting, __ground

__normal:
	integer 1, 1, 1, 1, 1, 1, 1, 1, 1
__grass:
	integer 1, 1, 2, 1, 1, 1, 1, 1, 2
__water:
	integer 1, 1, 1, 2, 1, 1, 1, 1, 2
__fire:
	integer 1, 2, 1, 1, 1, 1, 2, 1, 1
__electric:
	integer 1, 1, 2, 1, 1, 2, 2, 1, 0
__flying:
	integer 1, 2, 1, 1, 1, 1, 2, 2, 1
__bug:
	integer 1, 2, 1, 1, 1, 1, 1, 1, 1
__fighting:
	integer 2, 1, 1, 1, 1, 1, 1, 1, 1
__ground:
	integer 1, 1, 1, 1, 2, 0, 1, 1, 1

_DAT1END:
