; Set up texture, sound, and gamepad
	mov R0, 0
	out GPU_SelectedTexture, R0
	out INP_SelectedGamepad, R0
	out SPU_SelectedSound, 0
	out SPU_SelectedChannel, 1
	out SPU_ChannelAssignedSound, 0
; Set up regions
	mov R0, 0
	mov R1, 0
	mov R2, 0
	mov R3, 4
	mov R4, 4
	mov R5, 2
	mov R6, 2
	call _defineRegions
; Set up region
	mov R0, 0
	out GPU_SelectedRegion, R0
; Set drawing point and size
	mov R5, 320
	out GPU_DrawingPointX, R5
	mov R6, 180
	out GPU_DrawingPointY, R6
	mov R0, 5
	cif R0
	out GPU_DrawingScaleX, R0
	out GPU_DrawingScaleY, R0
; Draw the region and end
_mainLoop:
;	out SPU_Command, SPUCommand_PlaySelectedChannel
	out GPU_Command, GPUCommand_ClearScreen
	call _moveArrow
	call _BEEPCheck
	out GPU_DrawingPointX, R5
	out GPU_DrawingPointY, R6
	out GPU_Command, GPUCommand_DrawRegionZoomed
	wait
	jmp _mainLoop
_defineRegions:
	out GPU_SelectedRegion, R0
	out GPU_RegionMinX, R1
	out GPU_RegionMinY, R2
	out GPU_RegionMaxX, R3
	out GPU_RegionMaxY, R4
	out GPU_RegionHotspotX, R5
	out GPU_RegionHotspotY, R6
	iadd R0, 1
	iadd R1, 6 
	iadd R3, 6 
	iadd R5, 6
	mov R7, R0
	ieq R7, 11
	jf R7, _defineRegions
	ret
_moveArrow:
	mov R3, 0
	mov R4, 0
	jmp _leftcheck
_leftcheck:
	mov R7, R5
	in R1, INP_GamepadLeft
	ige R1, 1
	jf R1, _rightcheck
	mov R3, 6
	ilt R7, 11
	jt R7, _upcheck
	isub R5, 2
	jmp _upcheck
_rightcheck:
	mov R7, R5
	in R1, INP_GamepadRight
	ige R1, 1
	jf R1, _upcheck
	mov R3, 1
	igt R7, 625
	jt R7, _upcheck
	iadd R5, 2
	jmp _upcheck
_upcheck:
	mov R7, R6
	in R2, INP_GamepadUp
	ige R2, 1
	jf R2, _downcheck
	mov R4, 2
	ilt R7, 11
	jt R7, _finalRegion
	isub R6, 2
	jmp _finalRegion
_downcheck:
	mov R7, R6
	in R2, INP_GamepadDown
	ige R2, 1
	jf R2, _finalRegion
	mov R4, 4
	igt R7, 345
	jt R7, _finalRegion
	iadd R6, 2
	jmp _finalRegion
_finalRegion:
	iadd R3, R4
	out GPU_SelectedRegion, R3
	ret
_BEEPCheck:
	in R0, INP_GamepadLeft
	mov R1, R0
	ieq R1, 1
	jt R1, _BEEP
	in R0, INP_GamepadRight
	mov R1, R0
	ieq R1, 1
	jt R1, _BEEP
	in R0, INP_GamepadUp
	mov R1, R0
	ieq R1, 1
	jt R1, _BEEP
	in R0, INP_GamepadDown
	mov R1, R0
	ieq R1, 1
	jt R1, _BEEP
	ret
_BEEP:
	out SPU_Command, SPUCommand_PlaySelectedChannel
	ret
