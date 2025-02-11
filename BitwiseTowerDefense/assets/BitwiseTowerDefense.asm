; program start section
  call __global_scope_initialization
  call __function_main
  hlt

; location of global variables
  %define global_malloc_start_address 0
  %define global_malloc_end_address 1
  %define global_malloc_first_block 2

__global_scope_initialization:
  push BP
  mov BP, SP
  mov R0, 1048576
  mov [global_malloc_start_address], R0
  mov R0, 3145727
  mov [global_malloc_end_address], R0
  mov R0, -1
  mov [global_malloc_first_block], R0
  mov SP, BP
  pop BP
  ret

__function_select_sound:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedSound, R0
__function_select_sound_return:
  mov SP, BP
  pop BP
  ret

__function_get_selected_sound:
  push BP
  mov BP, SP
  in R0, SPU_SelectedSound
__function_get_selected_sound_return:
  mov SP, BP
  pop BP
  ret

__function_select_channel:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedChannel, R0
__function_select_channel_return:
  mov SP, BP
  pop BP
  ret

__function_get_selected_channel:
  push BP
  mov BP, SP
  in R0, SPU_SelectedChannel
__function_get_selected_channel_return:
  mov SP, BP
  pop BP
  ret

__function_set_sound_loop:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SoundPlayWithLoop, R0
__function_set_sound_loop_return:
  mov SP, BP
  pop BP
  ret

__function_set_sound_loop_start:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SoundLoopStart, R0
__function_set_sound_loop_start_return:
  mov SP, BP
  pop BP
  ret

__function_set_sound_loop_end:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SoundLoopEnd, R0
__function_set_sound_loop_end_return:
  mov SP, BP
  pop BP
  ret

__function_set_channel_volume:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_ChannelVolume, R0
__function_set_channel_volume_return:
  mov SP, BP
  pop BP
  ret

__function_set_channel_speed:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_ChannelSpeed, R0
__function_set_channel_speed_return:
  mov SP, BP
  pop BP
  ret

__function_set_channel_position:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_ChannelPosition, R0
__function_set_channel_position_return:
  mov SP, BP
  pop BP
  ret

__function_set_channel_loop:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_ChannelLoopEnabled, R0
__function_set_channel_loop_return:
  mov SP, BP
  pop BP
  ret

__function_assign_channel_sound:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedChannel, R0
  mov R0, [BP+3]
  out SPU_ChannelAssignedSound, R0
__function_assign_channel_sound_return:
  mov SP, BP
  pop BP
  ret

__function_get_channel_speed:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedChannel, R0
  in R0, SPU_ChannelSpeed
__function_get_channel_speed_return:
  mov SP, BP
  pop BP
  ret

__function_get_channel_position:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedChannel, R0
  in R0, SPU_ChannelPosition
__function_get_channel_position_return:
  mov SP, BP
  pop BP
  ret

__function_get_channel_state:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedChannel, R0
  in R0, SPU_ChannelState
__function_get_channel_state_return:
  mov SP, BP
  pop BP
  ret

__function_set_global_volume:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_GlobalVolume, R0
__function_set_global_volume_return:
  mov SP, BP
  pop BP
  ret

__function_get_global_volume:
  push BP
  mov BP, SP
  in R0, SPU_GlobalVolume
__function_get_global_volume_return:
  mov SP, BP
  pop BP
  ret

__function_play_channel:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedChannel, R0
  out SPU_Command, SPUCommand_PlaySelectedChannel
__function_play_channel_return:
  mov SP, BP
  pop BP
  ret

__function_pause_channel:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedChannel, R0
  out SPU_Command, SPUCommand_PauseSelectedChannel
__function_pause_channel_return:
  mov SP, BP
  pop BP
  ret

__function_stop_channel:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedChannel, R0
  out SPU_Command, SPUCommand_StopSelectedChannel
__function_stop_channel_return:
  mov SP, BP
  pop BP
  ret

__function_pause_all_channels:
  push BP
  mov BP, SP
  out SPU_Command, SPUCommand_PauseAllChannels
__function_pause_all_channels_return:
  mov SP, BP
  pop BP
  ret

__function_stop_all_channels:
  push BP
  mov BP, SP
  out SPU_Command, SPUCommand_StopAllChannels
__function_stop_all_channels_return:
  mov SP, BP
  pop BP
  ret

__function_resume_all_channels:
  push BP
  mov BP, SP
  out SPU_Command, SPUCommand_ResumeAllChannels
__function_resume_all_channels_return:
  mov SP, BP
  pop BP
  ret

__function_play_sound_in_channel:
  push BP
  mov BP, SP
  mov R0, [BP+3]
  out SPU_SelectedChannel, R0
  mov R0, [BP+2]
  out SPU_ChannelAssignedSound, R0
  out SPU_Command, SPUCommand_PlaySelectedChannel
__function_play_sound_in_channel_return:
  mov SP, BP
  pop BP
  ret

__function_play_sound:
  push BP
  mov BP, SP
  push R1
  mov R0, 0
__play_sound_begin_loop:
  out SPU_SelectedChannel, R0
  in R1, SPU_ChannelState
  ieq R1, 0x40
  jt R1, __play_sound_channel_found
  iadd R0, 1
  mov R1, R0
  ige R1, 16
  jf R1, __play_sound_begin_loop
  mov R0, -1
  jmp __play_sound_exit
__play_sound_channel_found:
  mov R1, [BP+2]
  out SPU_ChannelAssignedSound, R1
  out SPU_Command, SPUCommand_PlaySelectedChannel
__play_sound_exit:
  pop R1
__function_play_sound_return:
  mov SP, BP
  pop BP
  ret

__function_make_gray:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  shl R0, 16
  or R0, -16777216
  mov R1, [BP+2]
  shl R1, 8
  or R0, R1
  mov R1, [BP+2]
  or R0, R1
__function_make_gray_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_make_color_rgb:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+4]
  shl R0, 16
  or R0, -16777216
  mov R1, [BP+3]
  shl R1, 8
  or R0, R1
  mov R1, [BP+2]
  or R0, R1
__function_make_color_rgb_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_make_color_rgba:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+5]
  shl R0, 24
  mov R1, [BP+4]
  shl R1, 16
  or R0, R1
  mov R1, [BP+3]
  shl R1, 8
  or R0, R1
  mov R1, [BP+2]
  or R0, R1
__function_make_color_rgba_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_get_color_red:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  and R0, 255
__function_get_color_red_return:
  mov SP, BP
  pop BP
  ret

__function_get_color_green:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  shl R0, -8
  and R0, 255
__function_get_color_green_return:
  mov SP, BP
  pop BP
  ret

__function_get_color_blue:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  shl R0, -16
  and R0, 255
__function_get_color_blue_return:
  mov SP, BP
  pop BP
  ret

__function_get_color_alpha:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  shl R0, -24
  and R0, 255
__function_get_color_alpha_return:
  mov SP, BP
  pop BP
  ret

__function_select_texture:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_SelectedTexture, R0
__function_select_texture_return:
  mov SP, BP
  pop BP
  ret

__function_get_selected_texture:
  push BP
  mov BP, SP
  in R0, GPU_SelectedTexture
__function_get_selected_texture_return:
  mov SP, BP
  pop BP
  ret

__function_select_region:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_SelectedRegion, R0
__function_select_region_return:
  mov SP, BP
  pop BP
  ret

__function_get_selected_region:
  push BP
  mov BP, SP
  in R0, GPU_SelectedRegion
__function_get_selected_region_return:
  mov SP, BP
  pop BP
  ret

__function_define_region:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_RegionMinX, R0
  mov R0, [BP+3]
  out GPU_RegionMinY, R0
  mov R0, [BP+4]
  out GPU_RegionMaxX, R0
  mov R0, [BP+5]
  out GPU_RegionMaxY, R0
  mov R0, [BP+6]
  out GPU_RegionHotSpotX, R0
  mov R0, [BP+7]
  out GPU_RegionHotSpotY, R0
__function_define_region_return:
  mov SP, BP
  pop BP
  ret

__function_define_region_topleft:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_RegionMinX, R0
  out GPU_RegionHotSpotX, R0
  mov R0, [BP+3]
  out GPU_RegionMinY, R0
  out GPU_RegionHotSpotY, R0
  mov R0, [BP+4]
  out GPU_RegionMaxX, R0
  mov R0, [BP+5]
  out GPU_RegionMaxY, R0
__function_define_region_topleft_return:
  mov SP, BP
  pop BP
  ret

__function_define_region_center:
  push BP
  mov BP, SP
  isub SP, 2
  mov R0, [BP+2]
  mov R1, [BP+4]
  iadd R0, R1
  idiv R0, 2
  mov [BP-1], R0
  mov R0, [BP+3]
  mov R1, [BP+5]
  iadd R0, R1
  idiv R0, 2
  mov [BP-2], R0
  mov R0, [BP+2]
  out GPU_RegionMinX, R0
  mov R0, [BP+3]
  out GPU_RegionMinY, R0
  mov R0, [BP+4]
  out GPU_RegionMaxX, R0
  mov R0, [BP+5]
  out GPU_RegionMaxY, R0
  mov R0, [BP-1]
  out GPU_RegionHotSpotX, R0
  mov R0, [BP-2]
  out GPU_RegionHotSpotY, R0
__function_define_region_center_return:
  mov SP, BP
  pop BP
  ret

__function_define_region_matrix:
  push BP
  mov BP, SP
  isub SP, 17
  mov R0, [BP+2]
  mov [BP-1], R0
  mov R0, [BP+3]
  mov [BP-2], R0
  mov R0, [BP+4]
  mov [BP-3], R0
  mov R0, [BP+5]
  mov [BP-4], R0
  mov R0, [BP+6]
  mov [BP-5], R0
  mov R0, [BP+7]
  mov [BP-6], R0
  mov R0, [BP+8]
  mov [BP-7], R0
  mov R0, [BP-4]
  mov R1, [BP-2]
  isub R0, R1
  iadd R0, 1
  mov R1, [BP+11]
  iadd R0, R1
  mov [BP-8], R0
  mov R0, [BP-5]
  mov R1, [BP-3]
  isub R0, R1
  iadd R0, 1
  mov R1, [BP+11]
  iadd R0, R1
  mov [BP-9], R0
  mov R0, 0
  mov [BP-10], R0
__for_298_start:
  mov R0, [BP-10]
  mov R1, [BP+10]
  ilt R0, R1
  jf R0, __for_298_end
  mov R0, 0
  mov [BP-11], R0
__for_308_start:
  mov R0, [BP-11]
  mov R1, [BP+9]
  ilt R0, R1
  jf R0, __for_308_end
  mov R1, [BP-1]
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  mov R1, [BP-5]
  mov [SP+3], R1
  mov R1, [BP-6]
  mov [SP+4], R1
  mov R1, [BP-7]
  mov [SP+5], R1
  call __function_define_region
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  mov R0, [BP-2]
  mov R1, [BP-8]
  iadd R0, R1
  mov [BP-2], R0
  mov R0, [BP-4]
  mov R1, [BP-8]
  iadd R0, R1
  mov [BP-4], R0
  mov R0, [BP-6]
  mov R1, [BP-8]
  iadd R0, R1
  mov [BP-6], R0
__for_308_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_308_start
__for_308_end:
  mov R0, [BP-3]
  mov R1, [BP-9]
  iadd R0, R1
  mov [BP-3], R0
  mov R0, [BP-5]
  mov R1, [BP-9]
  iadd R0, R1
  mov [BP-5], R0
  mov R0, [BP-7]
  mov R1, [BP-9]
  iadd R0, R1
  mov [BP-7], R0
  mov R0, [BP+3]
  mov [BP-2], R0
  mov R0, [BP+5]
  mov [BP-4], R0
  mov R0, [BP+7]
  mov [BP-6], R0
__for_298_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_298_start
__for_298_end:
__function_define_region_matrix_return:
  mov SP, BP
  pop BP
  ret

__function_set_region_hotspot:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_RegionHotSpotX, R0
  mov R0, [BP+3]
  out GPU_RegionHotSpotY, R0
__function_set_region_hotspot_return:
  mov SP, BP
  pop BP
  ret

__function_set_multiply_color:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_MultiplyColor, R0
__function_set_multiply_color_return:
  mov SP, BP
  pop BP
  ret

__function_set_drawing_point:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
__function_set_drawing_point_return:
  mov SP, BP
  pop BP
  ret

__function_set_drawing_scale:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingScaleX, R0
  mov R0, [BP+3]
  out GPU_DrawingScaleY, R0
__function_set_drawing_scale_return:
  mov SP, BP
  pop BP
  ret

__function_set_drawing_angle:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingAngle, R0
__function_set_drawing_angle_return:
  mov SP, BP
  pop BP
  ret

__function_set_blending_mode:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_ActiveBlending, R0
__function_set_blending_mode_return:
  mov SP, BP
  pop BP
  ret

__function_get_multiply_color:
  push BP
  mov BP, SP
  in R0, GPU_MultiplyColor
__function_get_multiply_color_return:
  mov SP, BP
  pop BP
  ret

__function_get_drawing_point:
  push BP
  mov BP, SP
  push R1
  in R0, GPU_DrawingPointX
  mov R1, [BP+2]
  mov [R1], R0
  in R0, GPU_DrawingPointY
  mov R1, [BP+3]
  mov [R1], R0
__function_get_drawing_point_return:
  mov SP, BP
  pop BP
  ret

__function_get_drawing_scale:
  push BP
  mov BP, SP
  push R1
  in R0, GPU_DrawingScaleX
  mov R1, [BP+2]
  mov [R1], R0
  in R0, GPU_DrawingScaleY
  mov R1, [BP+3]
  mov [R1], R0
__function_get_drawing_scale_return:
  mov SP, BP
  pop BP
  ret

__function_get_drawing_angle:
  push BP
  mov BP, SP
  in R0, GPU_DrawingAngle
__function_get_drawing_angle_return:
  mov SP, BP
  pop BP
  ret

__function_get_blending_mode:
  push BP
  mov BP, SP
  in R0, GPU_ActiveBlending
__function_get_blending_mode_return:
  mov SP, BP
  pop BP
  ret

__function_clear_screen:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_ClearColor, R0
  out GPU_Command, GPUCommand_ClearScreen
__function_clear_screen_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region:
  push BP
  mov BP, SP
  out GPU_Command, GPUCommand_DrawRegion
__function_draw_region_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegion
__function_draw_region_at_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_zoomed:
  push BP
  mov BP, SP
  out GPU_Command, GPUCommand_DrawRegionZoomed
__function_draw_region_zoomed_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_zoomed_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegionZoomed
__function_draw_region_zoomed_at_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_rotated:
  push BP
  mov BP, SP
  out GPU_Command, GPUCommand_DrawRegionRotated
__function_draw_region_rotated_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_rotated_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegionRotated
__function_draw_region_rotated_at_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_rotozoomed:
  push BP
  mov BP, SP
  out GPU_Command, GPUCommand_DrawRegionRotozoomed
__function_draw_region_rotozoomed_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_rotozoomed_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegionRotozoomed
__function_draw_region_rotozoomed_at_return:
  mov SP, BP
  pop BP
  ret

__function_print_at:
  push BP
  mov BP, SP
  isub SP, 4
  call __function_get_selected_texture
  mov [BP-1], R0
  mov R1, -1
  mov [SP], R1
  call __function_select_texture
  mov R0, [BP+2]
  mov [BP-2], R0
__while_453_start:
__while_453_continue:
  mov R0, [BP+4]
  mov R0, [R0]
  cib R0
  jf R0, __while_453_end
  mov R1, [BP+4]
  mov R1, [R1]
  mov [SP], R1
  call __function_select_region
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_at
  mov R0, [BP+2]
  iadd R0, 10
  mov [BP+2], R0
__if_466_start:
  mov R0, [BP+4]
  mov R0, [R0]
  ieq R0, 10
  jf R0, __if_466_end
  mov R0, [BP-2]
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 20
  mov [BP+3], R0
__if_466_end:
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP+4], R0
  jmp __while_453_start
__while_453_end:
  mov R1, [BP-1]
  mov [SP], R1
  call __function_select_texture
__function_print_at_return:
  mov SP, BP
  pop BP
  ret

__function_print:
  push BP
  mov BP, SP
  isub SP, 5
  lea R1, [BP-1]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_get_drawing_point
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP+2]
  mov [SP+2], R1
  call __function_print_at
__function_print_return:
  mov SP, BP
  pop BP
  ret

__function_select_gamepad:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out INP_SelectedGamepad, R0
__function_select_gamepad_return:
  mov SP, BP
  pop BP
  ret

__function_get_selected_gamepad:
  push BP
  mov BP, SP
  in R0, INP_SelectedGamepad
__function_get_selected_gamepad_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_is_connected:
  push BP
  mov BP, SP
  in R0, INP_GamepadConnected
__function_gamepad_is_connected_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_left:
  push BP
  mov BP, SP
  in R0, INP_GamepadLeft
__function_gamepad_left_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_right:
  push BP
  mov BP, SP
  in R0, INP_GamepadRight
__function_gamepad_right_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_up:
  push BP
  mov BP, SP
  in R0, INP_GamepadUp
__function_gamepad_up_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_down:
  push BP
  mov BP, SP
  in R0, INP_GamepadDown
__function_gamepad_down_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_direction:
  push BP
  mov BP, SP
__if_515_start:
  call __function_gamepad_left
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_515_else
  mov R0, -1
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_515_end
__if_515_else:
__if_524_start:
  call __function_gamepad_right
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_524_else
  mov R0, 1
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_524_end
__if_524_else:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__if_524_end:
__if_515_end:
__if_536_start:
  call __function_gamepad_up
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_536_else
  mov R0, -1
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_536_end
__if_536_else:
__if_545_start:
  call __function_gamepad_down
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_545_else
  mov R0, 1
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_545_end
__if_545_else:
  mov R0, 0
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__if_545_end:
__if_536_end:
__function_gamepad_direction_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_direction_normalized:
  push BP
  mov BP, SP
__if_560_start:
  call __function_gamepad_left
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_560_else
  mov R0, -1.000000
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_560_end
__if_560_else:
__if_569_start:
  call __function_gamepad_right
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_569_else
  mov R0, 1.000000
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_569_end
__if_569_else:
  mov R0, 0.000000
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__if_569_end:
__if_560_end:
__if_581_start:
  call __function_gamepad_up
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_581_else
  mov R0, -1.000000
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_581_end
__if_581_else:
__if_590_start:
  call __function_gamepad_down
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_590_else
  mov R0, 1.000000
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_590_end
__if_590_else:
  mov R0, 0.000000
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__if_590_end:
__if_581_end:
__if_602_start:
  mov R0, [BP+2]
  mov R0, [R0]
  cfb R0
  jf R0, __LogicalAnd_ShortCircuit_605
  mov R1, [BP+3]
  mov R1, [R1]
  cfb R1
  and R0, R1
__LogicalAnd_ShortCircuit_605:
  jf R0, __if_602_end
  mov R0, [BP+2]
  mov R0, [R0]
  fmul R0, 0.707107
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  mov R0, [R0]
  fmul R0, 0.707107
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__if_602_end:
__function_gamepad_direction_normalized_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_a:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonA
__function_gamepad_button_a_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_b:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonB
__function_gamepad_button_b_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_x:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonX
__function_gamepad_button_x_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_y:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonY
__function_gamepad_button_y_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_l:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonL
__function_gamepad_button_l_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_r:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonR
__function_gamepad_button_r_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_start:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonStart
__function_gamepad_button_start_return:
  mov SP, BP
  pop BP
  ret

__function_get_cycle_counter:
  push BP
  mov BP, SP
  in R0, TIM_CycleCounter
__function_get_cycle_counter_return:
  mov SP, BP
  pop BP
  ret

__function_get_frame_counter:
  push BP
  mov BP, SP
  in R0, TIM_FrameCounter
__function_get_frame_counter_return:
  mov SP, BP
  pop BP
  ret

__function_get_date:
  push BP
  mov BP, SP
  in R0, TIM_CurrentDate
__function_get_date_return:
  mov SP, BP
  pop BP
  ret

__function_get_time:
  push BP
  mov BP, SP
  in R0, TIM_CurrentTime
__function_get_time_return:
  mov SP, BP
  pop BP
  ret

__function_translate_date:
  push BP
  mov BP, SP
  isub SP, 15
  mov R0, [BP+2]
  shl R0, -16
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP+2]
  and R0, 65535
  mov [BP-1], R0
  mov R0, 31
  mov [BP-13], R0
  mov R0, 28
  mov [BP-12], R0
  mov R0, 31
  mov [BP-11], R0
  mov R0, 30
  mov [BP-10], R0
  mov R0, 31
  mov [BP-9], R0
  mov R0, 30
  mov [BP-8], R0
  mov R0, 31
  mov [BP-7], R0
  mov R0, 31
  mov [BP-6], R0
  mov R0, 30
  mov [BP-5], R0
  mov R0, 31
  mov [BP-4], R0
  mov R0, 30
  mov [BP-3], R0
  mov R0, 31
  mov [BP-2], R0
  mov R1, [BP+3]
  mov R0, [R1]
  imod R0, 4
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_686
  mov R2, [BP+3]
  mov R1, [R2]
  imod R1, 100
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_686:
  mov [BP-14], R0
__if_695_start:
  mov R0, [BP-14]
  jf R0, __if_695_end
  mov R0, 29
  mov [BP-12], R0
__if_695_end:
  mov R0, 1
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov [BP-15], R0
__for_706_start:
  mov R0, [BP-15]
  ilt R0, 11
  jf R0, __for_706_end
__if_716_start:
  mov R0, [BP-1]
  lea R1, [BP-13]
  mov R2, [BP-15]
  iadd R1, R2
  mov R1, [R1]
  ilt R0, R1
  jf R0, __if_716_end
  mov R0, [BP-1]
  iadd R0, 1
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  jmp __function_translate_date_return
__if_716_end:
  mov R0, [BP-1]
  lea R1, [BP-13]
  mov R2, [BP-15]
  iadd R1, R2
  mov R1, [R1]
  isub R0, R1
  mov [BP-1], R0
  mov R2, [BP+3]
  iadd R2, 1
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__for_706_continue:
  mov R0, [BP-15]
  iadd R0, 1
  mov [BP-15], R0
  jmp __for_706_start
__for_706_end:
  mov R0, 12
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-1]
  iadd R0, 1
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
__function_translate_date_return:
  mov SP, BP
  pop BP
  ret

__function_translate_time:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  idiv R0, 3600
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP+2]
  imod R0, 3600
  idiv R0, 60
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+2]
  imod R0, 60
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
__function_translate_time_return:
  mov SP, BP
  pop BP
  ret

__function_end_frame:
  push BP
  mov BP, SP
  wait
__function_end_frame_return:
  mov SP, BP
  pop BP
  ret

__function_sleep:
  push BP
  mov BP, SP
  isub SP, 2
  call __function_get_frame_counter
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP+2]
  iadd R0, R1
  mov [BP-2], R0
__while_791_start:
__while_791_continue:
  call __function_get_frame_counter
  mov R1, R0
  mov R2, [BP-2]
  ilt R1, R2
  mov R0, R1
  jf R0, __while_791_end
  call __function_end_frame
  jmp __while_791_start
__while_791_end:
__function_sleep_return:
  mov SP, BP
  pop BP
  ret

__function_fmod:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  fmod R0, R1
  pop R1
__function_fmod_return:
  mov SP, BP
  pop BP
  ret

__function_min:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  imin R0, R1
  pop R1
__function_min_return:
  mov SP, BP
  pop BP
  ret

__function_max:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  imax R0, R1
  pop R1
__function_max_return:
  mov SP, BP
  pop BP
  ret

__function_abs:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  iabs R0
__function_abs_return:
  mov SP, BP
  pop BP
  ret

__function_fmin:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  fmin R0, R1
  pop R1
__function_fmin_return:
  mov SP, BP
  pop BP
  ret

__function_fmax:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  fmax R0, R1
  pop R1
__function_fmax_return:
  mov SP, BP
  pop BP
  ret

__function_fabs:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  fabs R0
__function_fabs_return:
  mov SP, BP
  pop BP
  ret

__function_floor:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  flr R0
__function_floor_return:
  mov SP, BP
  pop BP
  ret

__function_ceil:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  ceil R0
__function_ceil_return:
  mov SP, BP
  pop BP
  ret

__function_round:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  round R0
__function_round_return:
  mov SP, BP
  pop BP
  ret

__function_sin:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  sin R0
__function_sin_return:
  mov SP, BP
  pop BP
  ret

__function_cos:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  fadd R0, 1.570796
  sin R0
__function_cos_return:
  mov SP, BP
  pop BP
  ret

__function_tan:
  push BP
  mov BP, SP
  push R1
  mov R1, [BP+2]
  mov R0, R1
  sin R0
  fadd R1, 1.570796
  sin R1
  fdiv R0, R1
  pop R1
__function_tan_return:
  mov SP, BP
  pop BP
  ret

__function_asin:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  acos R0
  fsgn R0
  fadd R0, 1.570796
__function_asin_return:
  mov SP, BP
  pop BP
  ret

__function_acos:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  acos R0
__function_acos_return:
  mov SP, BP
  pop BP
  ret

__function_atan2:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  atan2 R0, R1
  pop R1
__function_atan2_return:
  mov SP, BP
  pop BP
  ret

__function_sqrt:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, 0.5
  pow R0, R1
  pop R1
__function_sqrt_return:
  mov SP, BP
  pop BP
  ret

__function_pow:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  pow R0, R1
  pop R1
__function_pow_return:
  mov SP, BP
  pop BP
  ret

__function_exp:
  push BP
  mov BP, SP
  push R1
  mov R0, 2.718282
  mov R1, [BP+2]
  pow R0, R1
  pop R1
__function_exp_return:
  mov SP, BP
  pop BP
  ret

__function_log:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  log R0
__function_log_return:
  mov SP, BP
  pop BP
  ret

__function_memset:
  push BP
  mov BP, SP
  mov CR, [BP+4]
  mov DR, [BP+2]
  mov SR, [BP+3]
  sets
__function_memset_return:
  mov SP, BP
  pop BP
  ret

__function_memcpy:
  push BP
  mov BP, SP
  mov CR, [BP+4]
  mov DR, [BP+2]
  mov SR, [BP+3]
  movs
__function_memcpy_return:
  mov SP, BP
  pop BP
  ret

__function_memcmp:
  push BP
  mov BP, SP
  mov CR, [BP+4]
  mov DR, [BP+2]
  mov SR, [BP+3]
  cmps R0
__function_memcmp_return:
  mov SP, BP
  pop BP
  ret

__function_merge_free_malloc_blocks:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_956_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_958
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_958:
  jf R0, __if_956_end
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_967_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_967_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_967_end:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 4
  iadd R0, R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_956_end:
__if_986_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_988
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_988:
  jf R0, __if_986_end
  mov R0, [BP-2]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_996_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_996_end
  mov R0, [BP-1]
  mov R1, [BP-2]
  mov [R1], R0
__if_996_end:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 4
  iadd R0, R1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
__if_986_end:
__function_merge_free_malloc_blocks_return:
  mov SP, BP
  pop BP
  ret

__function_reduce_malloc_block:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+3]
  isub R0, R1
  mov [BP-1], R0
__if_1018_start:
  mov R0, [BP-1]
  ile R0, 4
  jf R0, __if_1018_end
  jmp __function_reduce_malloc_block_return
__if_1018_end:
  mov R0, [BP+2]
  iadd R0, 4
  mov R1, [BP+3]
  iadd R0, R1
  mov [BP-2], R0
  mov R0, [BP+2]
  mov R1, [BP-2]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 1
  mov [R1], R0
  mov R0, 1
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  isub R0, 4
  mov R1, [BP-2]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_1061_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_1061_end
  mov R0, [BP-2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_1061_end:
  mov R1, [BP-2]
  mov [SP], R1
  call __function_merge_free_malloc_blocks
__function_reduce_malloc_block_return:
  mov SP, BP
  pop BP
  ret

__function_expand_malloc_block:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
  isub SP, 2
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  isub R0, R1
  mov [BP-1], R0
__if_1080_start:
  mov R0, [BP-1]
  ile R0, 0
  jf R0, __if_1080_end
  mov R0, 1
  jmp __function_expand_malloc_block_return
__if_1080_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_1090_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jt R0, __LogicalOr_ShortCircuit_1093
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  bnot R1
  or R0, R1
__LogicalOr_ShortCircuit_1093:
  jf R0, __if_1090_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_1090_end:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  iadd R0, 4
  mov [BP-3], R0
__if_1105_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_1105_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_1105_end:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R0, R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_1120_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_1120_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_1120_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_reduce_malloc_block
  mov R0, 1
__function_expand_malloc_block_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_malloc:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
__if_1135_start:
  mov R0, [global_malloc_first_block]
  ine R0, -1
  bnot R0
  jf R0, __if_1135_end
  mov R0, [global_malloc_start_address]
  mov [global_malloc_first_block], R0
  mov R0, [global_malloc_end_address]
  mov R1, [global_malloc_start_address]
  isub R0, R1
  iadd R0, 1
  mov R1, [global_malloc_first_block]
  iadd R1, 2
  mov [R1], R0
  mov R1, [global_malloc_first_block]
  iadd R1, 2
  mov R0, [R1]
  isub R0, 4
  mov R1, [global_malloc_first_block]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [global_malloc_first_block]
  mov [R1], R0
  mov R0, -1
  mov R1, [global_malloc_first_block]
  iadd R1, 1
  mov [R1], R0
  mov R0, 1
  mov R1, [global_malloc_first_block]
  iadd R1, 3
  mov [R1], R0
__if_1135_end:
__if_1170_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_1170_end
  mov R0, -1
  jmp __function_malloc_return
__if_1170_end:
  mov R0, [global_malloc_first_block]
  mov [BP-1], R0
__while_1179_start:
__while_1179_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_1179_end
__if_1182_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_1185
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP+2]
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1185:
  jf R0, __if_1182_end
  jmp __while_1179_end
__if_1182_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_1179_start
__while_1179_end:
__if_1195_start:
  mov R0, [BP-1]
  ine R0, -1
  bnot R0
  jf R0, __if_1195_end
  mov R0, -1
  jmp __function_malloc_return
__if_1195_end:
  mov R0, [BP+2]
  iadd R0, 4
  mov [BP-2], R0
__if_1205_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  igt R0, R1
  jf R0, __if_1205_else
  mov R0, [BP-1]
  iadd R0, 4
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  iadd R0, R1
  mov R1, [BP-2]
  isub R0, R1
  mov [BP-3], R0
  mov R0, [BP+2]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP-3]
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  isub R0, R1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_1250_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_1250_end
  mov R0, [BP-3]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_1250_end:
  mov R0, [BP-3]
  iadd R0, 4
  jmp __function_malloc_return
  jmp __if_1205_end
__if_1205_else:
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  iadd R0, 4
  jmp __function_malloc_return
__if_1205_end:
__function_malloc_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_free:
  push BP
  mov BP, SP
  isub SP, 2
__if_1275_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_1275_end
  jmp __function_free_return
__if_1275_end:
  mov R0, [BP+2]
  isub R0, 4
  mov [BP-1], R0
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R1, [BP-1]
  mov [SP], R1
  call __function_merge_free_malloc_blocks
__function_free_return:
  mov SP, BP
  pop BP
  ret

__function_calloc:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  isub SP, 3
  mov R0, [BP+2]
  mov R1, [BP+3]
  imul R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  mov [SP], R1
  call __function_malloc
  mov [BP-2], R0
__if_1303_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jf R0, __if_1303_end
  mov R0, -1
  jmp __function_calloc_return
__if_1303_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, [BP-1]
  mov [SP+2], R1
  call __function_memset
  mov R0, [BP-2]
__function_calloc_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_realloc:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  isub SP, 3
__if_1317_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_1317_end
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  jmp __function_realloc_return
__if_1317_end:
__if_1323_start:
  mov R0, [BP+3]
  ile R0, 0
  jf R0, __if_1323_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  jmp __function_realloc_return
__if_1323_end:
  mov R0, [BP+2]
  isub R0, 4
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
__if_1342_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_1342_end
  mov R0, [BP+2]
  jmp __function_realloc_return
__if_1342_end:
__if_1348_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __if_1348_else
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_reduce_malloc_block
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_1348_end
__if_1348_else:
__if_1359_start:
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_expand_malloc_block
  jf R0, __if_1359_else
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_1359_end
__if_1359_else:
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  mov [BP-3], R0
__if_1370_start:
  mov R0, [BP-3]
  ine R0, -1
  bnot R0
  jf R0, __if_1370_end
  mov R0, -1
  jmp __function_realloc_return
__if_1370_end:
  mov R1, [BP-3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  call __function_memcpy
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, [BP-3]
  jmp __function_realloc_return
__if_1359_end:
__if_1348_end:
__function_realloc_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rand:
  push BP
  mov BP, SP
  in R0, RNG_CurrentValue
__function_rand_return:
  mov SP, BP
  pop BP
  ret

__function_srand:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out RNG_CurrentValue, R0
__function_srand_return:
  mov SP, BP
  pop BP
  ret

__function_exit:
  push BP
  mov BP, SP
  hlt
__function_exit_return:
  mov SP, BP
  pop BP
  ret

__function_isdigit:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  ige R0, 48
  jf R0, __LogicalAnd_ShortCircuit_1399
  mov R1, [BP+2]
  ile R1, 57
  and R0, R1
__LogicalAnd_ShortCircuit_1399:
__function_isdigit_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isxdigit:
  push BP
  mov BP, SP
  push R1
__if_1404_start:
  mov R0, [BP+2]
  ige R0, 48
  jf R0, __LogicalAnd_ShortCircuit_1409
  mov R1, [BP+2]
  ile R1, 57
  and R0, R1
__LogicalAnd_ShortCircuit_1409:
  jf R0, __if_1404_end
  mov R0, 1
  jmp __function_isxdigit_return
__if_1404_end:
__if_1414_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_1419
  mov R1, [BP+2]
  ile R1, 102
  and R0, R1
__LogicalAnd_ShortCircuit_1419:
  jf R0, __if_1414_end
  mov R0, 1
  jmp __function_isxdigit_return
__if_1414_end:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_1430
  mov R1, [BP+2]
  ile R1, 70
  and R0, R1
__LogicalAnd_ShortCircuit_1430:
__function_isxdigit_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isalpha:
  push BP
  mov BP, SP
  push R1
__if_1435_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_1440
  mov R1, [BP+2]
  ile R1, 122
  and R0, R1
__LogicalAnd_ShortCircuit_1440:
  jf R0, __if_1435_end
  mov R0, 1
  jmp __function_isalpha_return
__if_1435_end:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_1451
  mov R1, [BP+2]
  ile R1, 90
  and R0, R1
__LogicalAnd_ShortCircuit_1451:
__function_isalpha_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isascii:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  ige R0, 0
  jf R0, __LogicalAnd_ShortCircuit_1462
  mov R1, [BP+2]
  ile R1, 127
  and R0, R1
__LogicalAnd_ShortCircuit_1462:
__function_isascii_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isalphanum:
  push BP
  mov BP, SP
  push R1
__if_1467_start:
  mov R0, [BP+2]
  ige R0, 48
  jf R0, __LogicalAnd_ShortCircuit_1472
  mov R1, [BP+2]
  ile R1, 57
  and R0, R1
__LogicalAnd_ShortCircuit_1472:
  jf R0, __if_1467_end
  mov R0, 1
  jmp __function_isalphanum_return
__if_1467_end:
__if_1477_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_1482
  mov R1, [BP+2]
  ile R1, 122
  and R0, R1
__LogicalAnd_ShortCircuit_1482:
  jf R0, __if_1477_end
  mov R0, 1
  jmp __function_isalphanum_return
__if_1477_end:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_1493
  mov R1, [BP+2]
  ile R1, 90
  and R0, R1
__LogicalAnd_ShortCircuit_1493:
__function_isalphanum_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_islower:
  push BP
  mov BP, SP
  push R1
__if_1498_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_1503
  mov R1, [BP+2]
  ile R1, 122
  and R0, R1
__LogicalAnd_ShortCircuit_1503:
  jf R0, __if_1498_end
  mov R0, 1
  jmp __function_islower_return
__if_1498_end:
  mov R0, [BP+2]
  ige R0, 224
  jf R0, __LogicalAnd_ShortCircuit_1514
  mov R1, [BP+2]
  ile R1, 254
  and R0, R1
__LogicalAnd_ShortCircuit_1514:
  jf R0, __LogicalAnd_ShortCircuit_1518
  mov R1, [BP+2]
  ine R1, 247
  and R0, R1
__LogicalAnd_ShortCircuit_1518:
__function_islower_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isupper:
  push BP
  mov BP, SP
  push R1
__if_1523_start:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_1528
  mov R1, [BP+2]
  ile R1, 90
  and R0, R1
__LogicalAnd_ShortCircuit_1528:
  jf R0, __if_1523_end
  mov R0, 1
  jmp __function_isupper_return
__if_1523_end:
  mov R0, [BP+2]
  ige R0, 192
  jf R0, __LogicalAnd_ShortCircuit_1539
  mov R1, [BP+2]
  ile R1, 222
  and R0, R1
__LogicalAnd_ShortCircuit_1539:
  jf R0, __LogicalAnd_ShortCircuit_1543
  mov R1, [BP+2]
  ine R1, 215
  and R0, R1
__LogicalAnd_ShortCircuit_1543:
__function_isupper_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isspace:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  ieq R0, 32
  jt R0, __LogicalOr_ShortCircuit_1554
  mov R1, [BP+2]
  ieq R1, 10
  or R0, R1
__LogicalOr_ShortCircuit_1554:
  jt R0, __LogicalOr_ShortCircuit_1558
  mov R1, [BP+2]
  ieq R1, 13
  or R0, R1
__LogicalOr_ShortCircuit_1558:
  jt R0, __LogicalOr_ShortCircuit_1562
  mov R1, [BP+2]
  ieq R1, 9
  or R0, R1
__LogicalOr_ShortCircuit_1562:
__function_isspace_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_tolower:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 1
__if_1567_start:
  mov R2, [BP+2]
  mov [SP], R2
  call __function_isupper
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_1567_end
  mov R0, [BP+2]
  jmp __function_tolower_return
__if_1567_end:
  mov R0, [BP+2]
  iadd R0, 32
__function_tolower_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_toupper:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 1
__if_1579_start:
  mov R2, [BP+2]
  mov [SP], R2
  call __function_islower
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_1579_end
  mov R0, [BP+2]
  jmp __function_toupper_return
__if_1579_end:
  mov R0, [BP+2]
  isub R0, 32
__function_toupper_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strlen:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  mov R0, [BP+2]
  mov [BP-1], R0
__while_1594_start:
__while_1594_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __while_1594_end
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  jmp __while_1594_start
__while_1594_end:
  mov R0, [BP+2]
  mov R1, [BP-1]
  isub R0, R1
__function_strlen_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strcmp:
  push BP
  mov BP, SP
  push R1
__while_1606_start:
__while_1606_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __LogicalAnd_ShortCircuit_1609
  mov R1, [BP+3]
  mov R1, [R1]
  cib R1
  and R0, R1
__LogicalAnd_ShortCircuit_1609:
  jf R0, __while_1606_end
__if_1613_start:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, [BP+3]
  mov R1, [R1]
  ine R0, R1
  jf R0, __if_1613_end
  jmp __while_1606_end
__if_1613_end:
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  jmp __while_1606_start
__while_1606_end:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, [BP+3]
  mov R1, [R1]
  isub R0, R1
__function_strcmp_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strncmp:
  push BP
  mov BP, SP
  push R1
__if_1634_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_1634_end
  mov R0, 0
  jmp __function_strncmp_return
__if_1634_end:
__while_1640_start:
__while_1640_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __LogicalAnd_ShortCircuit_1643
  mov R1, [BP+3]
  mov R1, [R1]
  cib R1
  and R0, R1
__LogicalAnd_ShortCircuit_1643:
  jf R0, __while_1640_end
  mov R0, [BP+4]
  isub R0, 1
  mov [BP+4], R0
__if_1649_start:
  mov R0, [BP+4]
  ile R0, 0
  jf R0, __if_1649_end
  jmp __while_1640_end
__if_1649_end:
__if_1654_start:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, [BP+3]
  mov R1, [R1]
  ine R0, R1
  jf R0, __if_1654_end
  jmp __while_1640_end
__if_1654_end:
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  jmp __while_1640_start
__while_1640_end:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, [BP+3]
  mov R1, [R1]
  isub R0, R1
__function_strncmp_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strcpy:
  push BP
  mov BP, SP
__while_1674_start:
__while_1674_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1674_end
  mov R0, [BP+3]
  mov R0, [R0]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  jmp __while_1674_start
__while_1674_end:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__function_strcpy_return:
  mov SP, BP
  pop BP
  ret

__function_strncpy:
  push BP
  mov BP, SP
__if_1695_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_1695_end
  jmp __function_strncpy_return
__if_1695_end:
__while_1700_start:
__while_1700_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1700_end
  mov R0, [BP+3]
  mov R0, [R0]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  mov R0, [BP+4]
  isub R0, 1
  mov [BP+4], R0
__if_1715_start:
  mov R0, [BP+4]
  ile R0, 0
  jf R0, __if_1715_end
  jmp __while_1700_end
__if_1715_end:
  jmp __while_1700_start
__while_1700_end:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__function_strncpy_return:
  mov SP, BP
  pop BP
  ret

__function_strcat:
  push BP
  mov BP, SP
__while_1727_start:
__while_1727_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __while_1727_end
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  jmp __while_1727_start
__while_1727_end:
__while_1732_start:
__while_1732_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1732_end
  mov R0, [BP+3]
  mov R0, [R0]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  jmp __while_1732_start
__while_1732_end:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__function_strcat_return:
  mov SP, BP
  pop BP
  ret

__function_strncat:
  push BP
  mov BP, SP
__if_1753_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_1753_end
  jmp __function_strncat_return
__if_1753_end:
__while_1758_start:
__while_1758_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __while_1758_end
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  jmp __while_1758_start
__while_1758_end:
__while_1763_start:
__while_1763_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1763_end
  mov R0, [BP+3]
  mov R0, [R0]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  mov R0, [BP+4]
  isub R0, 1
  mov [BP+4], R0
__if_1778_start:
  mov R0, [BP+4]
  ile R0, 0
  jf R0, __if_1778_end
  jmp __while_1763_end
__if_1778_end:
  jmp __while_1763_start
__while_1763_end:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__function_strncat_return:
  mov SP, BP
  pop BP
  ret

__function_itoa:
  push BP
  mov BP, SP
  isub SP, 51
  lea DR, [BP-17]
  mov SR, __literal_string_1796
  mov CR, 17
  movs
__if_1800_start:
  mov R0, [BP+4]
  ilt R0, 2
  jt R0, __LogicalOr_ShortCircuit_1805
  mov R1, [BP+4]
  igt R1, 16
  or R0, R1
__LogicalOr_ShortCircuit_1805:
  jf R0, __if_1800_end
  jmp __function_itoa_return
__if_1800_end:
__if_1809_start:
  mov R0, [BP+4]
  ieq R0, 10
  jf R0, __LogicalAnd_ShortCircuit_1814
  mov R1, [BP+2]
  ilt R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_1814:
  jf R0, __if_1809_end
  mov R0, 45
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  mov R0, [BP+2]
  isgn R0
  mov [BP+2], R0
__if_1809_end:
  lea R0, [BP-50]
  mov [BP-51], R0
__do_1831_start:
  lea R0, [BP-17]
  mov R1, [BP+2]
  mov R2, [BP+4]
  imod R1, R2
  iadd R0, R1
  mov R0, [R0]
  lea R1, [BP-51]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP-51]
  iadd R0, 1
  mov [BP-51], R0
  mov R0, [BP+2]
  mov R1, [BP+4]
  idiv R0, R1
  mov [BP+2], R0
__do_1831_continue:
  mov R0, [BP+2]
  cib R0
  jt R0, __do_1831_start
__do_1831_end:
__do_1847_start:
  mov R0, [BP-51]
  isub R0, 1
  mov [BP-51], R0
  mov R0, [BP-51]
  mov R0, [R0]
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
__do_1847_continue:
  mov R0, [BP-51]
  lea R1, [BP-50]
  ine R0, R1
  jt R0, __do_1847_start
__do_1847_end:
  mov R0, 0
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__function_itoa_return:
  mov SP, BP
  pop BP
  ret

__function_ftoa:
  push BP
  mov BP, SP
  isub SP, 14
__if_1871_start:
  mov R0, [BP+2]
  flt R0, 0.000000
  jf R0, __if_1871_end
  mov R0, 45
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  mov R0, [BP+2]
  fsgn R0
  mov [BP+2], R0
__if_1871_end:
  mov R0, [BP+2]
  flr R0
  cfi R0
  mov [BP-1], R0
  push R1
  mov R0, [BP+2]
  mov R1, [BP-1]
  cif R1
  fsub R0, R1
  fmul R0, 100000.0
  round R0
  cfi R0
  mov [BP-2], R0
  pop R1
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
__if_1900_start:
  mov R0, [BP-2]
  bnot R0
  jf R0, __if_1900_end
  jmp __function_ftoa_return
__if_1900_end:
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, __literal_string_1906
  mov [SP+1], R1
  call __function_strcat
  mov R0, [BP-2]
  mov [BP-3], R0
__while_1910_start:
__while_1910_continue:
  mov R0, [BP-3]
  ilt R0, 10000
  jf R0, __while_1910_end
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, __literal_string_1917
  mov [SP+1], R1
  call __function_strcat
  mov R0, [BP-3]
  imul R0, 10
  mov [BP-3], R0
  jmp __while_1910_start
__while_1910_end:
__while_1921_start:
__while_1921_continue:
  mov R0, [BP-2]
  imod R0, 10
  bnot R0
  jf R0, __while_1921_end
  mov R0, [BP-2]
  idiv R0, 10
  mov [BP-2], R0
  jmp __while_1921_start
__while_1921_end:
  mov R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  call __function_strcat
__function_ftoa_return:
  mov SP, BP
  pop BP
  ret

__function_mkenemy:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 1
  mov R0, -1
  mov [BP-1], R0
  mov R2, 10
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, -1
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+2]
  cif R0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+3]
  cif R0
  mov R1, [BP-1]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 6
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 7
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 8
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 9
  mov [R1], R0
  mov R0, [BP-1]
__function_mkenemy_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_mktower:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 1
  mov R0, -1
  mov [BP-1], R0
  mov R2, 10
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, -1
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+2]
  cif R0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+3]
  cif R0
  mov R1, [BP-1]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 6
  mov [R1], R0
  mov R0, 90
  mov R1, [BP-1]
  iadd R1, 7
  mov [R1], R0
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 8
  mov [R1], R0
  mov R0, 5
  mov R1, [BP-1]
  iadd R1, 9
  mov [R1], R0
  mov R0, [BP-1]
__function_mktower_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rmnode:
  push BP
  mov BP, SP
  push R1
  isub SP, 1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  mov [BP+2], R0
  mov R0, [BP+2]
__function_rmnode_return:
  iadd SP, 1
  pop R1
  mov SP, BP
  pop BP
  ret

__function_mklist:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 1
  mov R0, -1
  mov [BP-1], R0
  mov R2, 3
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-1]
__function_mklist_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_insert:
  push BP
  mov BP, SP
  push R1
  push R2
__if_2112_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_2112_else
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2112_end
__if_2112_else:
__if_2126_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2126_else
  mov R0, [BP+3]
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  jmp __if_2126_end
__if_2126_else:
  mov R0, [BP+3]
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP+4]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__if_2126_end:
__if_2112_end:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP+2]
__function_insert_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_append:
  push BP
  mov BP, SP
  push R1
  push R2
__if_2172_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_2172_else
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2172_end
__if_2172_else:
__if_2186_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2186_else
  mov R0, [BP+4]
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2186_end
__if_2186_else:
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+4]
  mov R2, [BP+3]
  mov R1, [R2]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+3]
  mov R0, [R1]
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+3]
  mov [R1], R0
__if_2186_end:
__if_2172_end:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP+2]
__function_append_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_obtain:
  push BP
  mov BP, SP
  push R1
  push R2
__if_2231_start:
  mov R0, [BP+3]
  mov R0, [R0]
  ine R0, -1
  jf R0, __if_2231_end
__if_2238_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2238_end
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  mov R1, [BP+2]
  mov [R1], R0
__if_2253_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2253_else
  mov R0, -1
  mov R2, [BP+2]
  mov R1, [R2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2253_end
__if_2253_else:
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_2253_end:
__if_2238_end:
__if_2269_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2269_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_2269_end:
__if_2289_start:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2289_end
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R2, [R2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_2289_end:
__if_2307_start:
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2307_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R2, [R2]
  mov R1, [R2]
  iadd R1, 1
  mov [R1], R0
__if_2307_end:
  mov R0, -1
  mov R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  isub R1, 1
  mov [R2], R1
__if_2231_end:
  mov R0, [BP+2]
__function_obtain_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_clearlist:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  lea R0, [BP-1]
  mov [BP-3], R0
__while_2356_start:
__while_2356_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_2356_end
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-3]
  mov [SP+1], R2
  call __function_obtain
  mov R1, R0
  mov [BP+2], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  call __function_rmnode
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, [BP-2]
  mov [BP-1], R0
__if_2373_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __if_2373_end
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  lea R0, [BP-1]
  mov [BP-3], R0
__if_2373_end:
  jmp __while_2356_start
__while_2356_end:
  mov R0, [BP+2]
__function_clearlist_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rmlist:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 1
  mov R2, [BP+2]
  mov [SP], R2
  call __function_clearlist
  mov R1, R0
  mov [BP+2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  mov [BP+2], R0
  mov R0, [BP+2]
__function_rmlist_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_mkqueue:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 1
  mov R0, -1
  mov [BP-1], R0
  mov R2, 7
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  call __function_mklist
  mov R1, R0
  mov R2, [BP-1]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov R0, [R1]
  mov R1, [BP-1]
  mov [R1], R0
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+2]
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 6
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP-1]
__function_mkqueue_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_dequeue:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 2
__if_2463_start:
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  ine R0, 0
  jf R0, __if_2463_end
__if_2463_end:
__if_2470_start:
  mov R0, [BP+3]
  mov R0, [R0]
  ine R0, -1
  jf R0, __if_2470_end
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_obtain
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov R0, [R1]
  mov R1, [BP+2]
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_2470_end:
  mov R2, [BP+2]
  iadd R2, 6
  mov R0, [R2]
  mov R1, R0
  isub R1, 1
  mov [R2], R1
  mov R0, [BP+2]
__function_dequeue_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_enqueue:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  push R4
  isub SP, 3
__if_2501_start:
  mov R0, [BP+3]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_2507
  mov R2, [BP+2]
  iadd R2, 6
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 5
  mov R2, [R3]
  ilt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2507:
  jf R0, __if_2501_end
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  mov [SP], R2
  mov R4, [BP+2]
  iadd R4, 2
  mov R3, [R4]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  mov R2, [BP+3]
  mov [SP+2], R2
  call __function_append
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov R0, [R1]
  mov R1, [BP+2]
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 6
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__if_2501_end:
  mov R0, [BP+2]
__function_enqueue_return:
  iadd SP, 3
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_clearqueue:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
__while_2545_start:
__while_2545_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_2545_end
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-1]
  mov [SP+1], R2
  call __function_dequeue
  mov R1, R0
  mov [BP+2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_2545_start
__while_2545_end:
  mov R0, [BP+2]
__function_clearqueue_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rmqueue:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  isub SP, 1
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  mov [SP], R2
  call __function_clearlist
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  mov [SP], R2
  call __function_rmlist
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  mov [BP+2], R0
  mov R0, [BP+2]
__function_rmqueue_return:
  iadd SP, 1
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_mkqueuelist:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 1
  mov R0, -1
  mov [BP-1], R0
  mov R2, 3
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, -1
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
__function_mkqueuelist_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_queueinsert:
  push BP
  mov BP, SP
  push R1
  push R2
__if_2618_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_2618_else
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2618_end
__if_2618_else:
__if_2632_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2632_else
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+3]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  jmp __if_2632_end
__if_2632_else:
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+4]
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  iadd R1, 3
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+3]
  iadd R1, 4
  mov [R1], R0
__if_2632_end:
__if_2618_end:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP+2]
__function_queueinsert_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_queueappend:
  push BP
  mov BP, SP
  push R1
  push R2
__if_2678_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_2678_else
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2678_end
__if_2678_else:
__if_2692_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2692_else
  mov R0, [BP+4]
  mov R1, [BP+3]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2692_end
__if_2692_else:
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP+4]
  mov R2, [BP+3]
  iadd R2, 3
  mov R1, [R2]
  iadd R1, 4
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+3]
  iadd R1, 3
  mov [R1], R0
__if_2692_end:
__if_2678_end:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP+2]
__function_queueappend_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_queueobtain:
  push BP
  mov BP, SP
  push R1
  push R2
__if_2737_start:
  mov R0, [BP+3]
  mov R0, [R0]
  ine R0, -1
  jf R0, __if_2737_end
__if_2744_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2744_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP+2]
  mov [R1], R0
__if_2759_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2759_else
  mov R0, -1
  mov R2, [BP+2]
  mov R1, [R2]
  iadd R1, 4
  mov [R1], R0
  jmp __if_2759_end
__if_2759_else:
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_2759_end:
__if_2744_end:
__if_2775_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2775_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 3
  mov [R1], R0
__if_2775_end:
__if_2795_start:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2795_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP+3]
  mov R2, [R2]
  iadd R2, 4
  mov R1, [R2]
  iadd R1, 3
  mov [R1], R0
__if_2795_end:
__if_2813_start:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2813_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+3]
  mov R2, [R2]
  iadd R2, 3
  mov R1, [R2]
  iadd R1, 4
  mov [R1], R0
__if_2813_end:
  mov R0, -1
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 3
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 4
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  isub R1, 1
  mov [R2], R1
__if_2737_end:
  mov R0, [BP+2]
__function_queueobtain_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_clearqueuelist:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  lea R0, [BP-1]
  mov [BP-3], R0
__while_2862_start:
__while_2862_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_2862_end
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-3]
  mov [SP+1], R2
  call __function_queueobtain
  mov R1, R0
  mov [BP+2], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  call __function_rmqueue
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, [BP-2]
  mov [BP-1], R0
__if_2879_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __if_2879_end
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  lea R0, [BP-1]
  mov [BP-3], R0
__if_2879_end:
  jmp __while_2862_start
__while_2862_end:
  mov R0, [BP+2]
__function_clearqueuelist_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rmqueuelist:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 1
  mov R2, [BP+2]
  mov [SP], R2
  call __function_clearqueuelist
  mov R1, R0
  mov [BP+2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  mov [BP+2], R0
  mov R0, [BP+2]
__function_rmqueuelist_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 60
  call __function_get_time
  mov R1, R0
  mov [BP-50], R1
  mov R1, [BP-50]
  mov [SP], R1
  call __function_srand
  mov R0, 255
  mov [BP-31], R0
  mov R0, 0
  mov [BP-32], R0
  mov R0, 16
  mov [BP-33], R0
  mov R0, 255
  mov [BP-34], R0
  mov R0, 9
  mov [BP-37], R0
  mov R0, 5
  mov [BP-38], R0
  mov R0, 0
  mov [BP-39], R0
  mov R0, 0
  mov [BP-40], R0
  mov R0, 1
  mov [BP-41], R0
  mov R0, -1
  mov [BP-42], R0
  mov R2, 10
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-42], R1
  mov R0, R1
  mov R0, -1
  mov [BP-43], R0
  mov R2, 10
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-43], R1
  mov R0, R1
  mov R1, 0
  mov [SP], R1
  call __function_select_texture
  mov R1, 0
  mov [SP], R1
  call __function_select_region
  mov R1, 0
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 639
  mov [SP+2], R1
  mov R1, 359
  mov [SP+3], R1
  call __function_define_region_topleft
  mov R1, 1
  mov [SP], R1
  call __function_select_texture
  mov R1, 1
  mov [SP], R1
  call __function_select_region
  mov R1, 1
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  mov R1, 31
  mov [SP+3], R1
  mov R1, 31
  mov [SP+4], R1
  mov R1, 0
  mov [SP+5], R1
  mov R1, 0
  mov [SP+6], R1
  mov R1, 2
  mov [SP+7], R1
  mov R1, 1
  mov [SP+8], R1
  mov R1, 0
  mov [SP+9], R1
  call __function_define_region_matrix
  mov R1, 2
  mov [SP], R1
  call __function_select_texture
  mov R1, 4
  mov [SP], R1
  call __function_select_region
  mov R1, 4
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  mov R1, 31
  mov [SP+3], R1
  mov R1, 31
  mov [SP+4], R1
  mov R1, 0
  mov [SP+5], R1
  mov R1, 0
  mov [SP+6], R1
  mov R1, 3
  mov [SP+7], R1
  mov R1, 6
  mov [SP+8], R1
  mov R1, 0
  mov [SP+9], R1
  call __function_define_region_matrix
  mov R1, 3
  mov [SP], R1
  call __function_select_texture
  mov R1, 25
  mov [SP], R1
  call __function_select_region
  mov R1, 0
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 194
  mov [SP+2], R1
  mov R1, 79
  mov [SP+3], R1
  call __function_define_region_topleft
  mov R1, 50
  mov [SP], R1
  call __function_mkqueue
  mov [BP-44], R0
  mov R1, 150
  mov [SP], R1
  call __function_mkqueue
  mov [BP-45], R0
  mov R1, 1
  mov [SP], R1
  call __function_mkqueue
  mov [BP-46], R0
__while_3020_start:
__while_3020_continue:
  call __function_gamepad_button_b
  mov R1, R0
  ile R1, 0
  mov R0, R1
  jf R0, __while_3020_end
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R1, 0
  mov [SP], R1
  mov R1, 10
  mov [SP+1], R1
  mov R1, __literal_string_3030
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 30
  mov [SP+1], R1
  mov R1, __literal_string_3034
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 50
  mov [SP+1], R1
  mov R1, __literal_string_3038
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 70
  mov [SP+1], R1
  mov R1, __literal_string_3042
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 90
  mov [SP+1], R1
  mov R1, __literal_string_3046
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 110
  mov [SP+1], R1
  mov R1, __literal_string_3050
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 130
  mov [SP+1], R1
  mov R1, __literal_string_3054
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 150
  mov [SP+1], R1
  mov R1, __literal_string_3058
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 190
  mov [SP+1], R1
  mov R1, __literal_string_3062
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 210
  mov [SP+1], R1
  mov R1, __literal_string_3066
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 230
  mov [SP+1], R1
  mov R1, __literal_string_3070
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 250
  mov [SP+1], R1
  mov R1, __literal_string_3074
  mov [SP+2], R1
  call __function_print_at
__if_3075_start:
  call __function_get_frame_counter
  mov R1, R0
  imod R1, 60
  ilt R1, 30
  mov R0, R1
  jf R0, __if_3075_else
  mov R1, 0
  mov [SP], R1
  mov R1, 290
  mov [SP+1], R1
  mov R1, __literal_string_3085
  mov [SP+2], R1
  call __function_print_at
  jmp __if_3075_end
__if_3075_else:
__if_3086_start:
  call __function_get_frame_counter
  mov R1, R0
  imod R1, 60
  igt R1, 30
  mov R0, R1
  jf R0, __if_3086_end
  mov R1, 0
  mov [SP], R1
  mov R1, 290
  mov [SP+1], R1
  mov R1, __literal_string_3096
  mov [SP+2], R1
  call __function_print_at
__if_3086_end:
__if_3075_end:
  call __function_end_frame
  jmp __while_3020_start
__while_3020_end:
  mov R0, 10
  mov [BP-35], R0
  mov R0, 180
  mov [BP-36], R0
  mov R1, 0
  mov [SP], R1
  call __function_select_sound
  mov R1, 1
  mov [SP], R1
  call __function_set_sound_loop
  mov R1, 0
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  call __function_play_sound_in_channel
  mov R1, 1
  mov [SP], R1
  call __function_select_channel
__while_3113_start:
__while_3113_continue:
  mov R0, 1
  jf R0, __while_3113_end
  mov R0, 255
  mov [BP-31], R0
  mov R0, 0
  mov [BP-32], R0
  mov R0, 16
  mov [BP-33], R0
  mov R0, 255
  mov [BP-34], R0
  mov R0, 9
  mov [BP-37], R0
  mov R0, 5
  mov [BP-38], R0
  mov R0, 0
  mov [BP-39], R0
  mov R0, 0
  mov [BP-40], R0
  mov R0, 1
  mov [BP-41], R0
  mov R2, [BP-44]
  mov [SP], R2
  call __function_clearqueue
  mov R1, R0
  mov [BP-44], R1
  mov R0, R1
  mov R2, [BP-45]
  mov [SP], R2
  call __function_clearqueue
  mov R1, R0
  mov [BP-45], R1
  mov R0, R1
  mov R2, [BP-46]
  mov [SP], R2
  call __function_clearqueue
  mov R1, R0
  mov [BP-46], R1
  mov R0, R1
__while_3155_start:
__while_3155_continue:
  mov R0, [BP-31]
  igt R0, 0
  jf R0, __while_3155_end
  mov R0, [BP-35]
  mov R1, R0
  isub R1, 1
  mov [BP-35], R1
  mov R0, [BP-36]
  mov R1, R0
  isub R1, 1
  mov [BP-36], R1
  mov R1, [BP-45]
  mov R0, [R1]
  mov [BP-42], R0
__while_3168_start:
__while_3168_continue:
  mov R0, [BP-42]
  ine R0, -1
  jf R0, __while_3168_end
  mov R2, [BP-42]
  iadd R2, 7
  mov R0, [R2]
  mov R1, R0
  isub R1, 1
  mov [R2], R1
  mov R1, [BP-42]
  mov R0, [R1]
  mov [BP-42], R0
  jmp __while_3168_start
__while_3168_end:
  mov R1, [BP-44]
  mov R0, [R1]
  mov [BP-42], R0
__while_3184_start:
__while_3184_continue:
  mov R0, [BP-42]
  ine R0, -1
  jf R0, __while_3184_end
__if_3189_start:
  call __function_get_frame_counter
  mov R1, R0
  imod R1, 15
  ieq R1, 0
  mov R0, R1
  jf R0, __if_3189_end
__if_3196_start:
  mov R1, [BP-42]
  iadd R1, 4
  mov R0, [R1]
  feq R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_3203
  mov R2, [BP-42]
  iadd R2, 4
  mov R1, [R2]
  feq R1, 20.000000
  or R0, R1
__LogicalOr_ShortCircuit_3203:
  jt R0, __LogicalOr_ShortCircuit_3208
  mov R2, [BP-42]
  iadd R2, 4
  mov R1, [R2]
  feq R1, 32.000000
  or R0, R1
__LogicalOr_ShortCircuit_3208:
  jf R0, __if_3196_end
  mov R2, [BP-42]
  iadd R2, 3
  mov R0, [R2]
  mov R1, R0
  fadd R1, 1.0
  mov [R2], R1
__if_3196_end:
__if_3215_start:
  mov R1, [BP-42]
  iadd R1, 3
  mov R0, [R1]
  feq R0, 20.000000
  jt R0, __LogicalOr_ShortCircuit_3222
  mov R2, [BP-42]
  iadd R2, 3
  mov R1, [R2]
  feq R1, 32.000000
  or R0, R1
__LogicalOr_ShortCircuit_3222:
  jt R0, __LogicalOr_ShortCircuit_3227
  mov R2, [BP-42]
  iadd R2, 3
  mov R1, [R2]
  feq R1, 72.000000
  or R0, R1
__LogicalOr_ShortCircuit_3227:
  jf R0, __if_3215_else
  mov R2, [BP-42]
  iadd R2, 4
  mov R0, [R2]
  mov R1, R0
  fadd R1, 1.0
  mov [R2], R1
  jmp __if_3215_end
__if_3215_else:
__if_3234_start:
  mov R1, [BP-42]
  iadd R1, 3
  mov R0, [R1]
  feq R0, 40.000000
  jf R0, __if_3234_end
  mov R2, [BP-42]
  iadd R2, 4
  mov R0, [R2]
  mov R1, R0
  fsub R1, 1.0
  mov [R2], R1
__if_3234_end:
__if_3215_end:
__if_3189_end:
__if_3243_start:
  mov R1, [BP-42]
  iadd R1, 3
  mov R0, [R1]
  fgt R0, 76.000000
  jf R0, __if_3243_else
  mov R0, [BP-31]
  mov R2, [BP-42]
  iadd R2, 2
  mov R1, [R2]
  isub R0, R1
  mov [BP-31], R0
  mov R2, [BP-44]
  mov [SP], R2
  lea R2, [BP-42]
  mov [SP+1], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-44], R1
  mov R0, R1
  mov R2, [BP-42]
  mov [SP], R2
  call __function_rmnode
  mov R1, R0
  mov [BP-42], R1
  mov R0, R1
  mov R1, [BP-44]
  mov R0, [R1]
  mov [BP-42], R0
  jmp __if_3243_end
__if_3243_else:
  mov R1, [BP-42]
  mov R0, [R1]
  mov [BP-42], R0
__if_3243_end:
  jmp __while_3184_start
__while_3184_end:
__if_3272_start:
  mov R0, [BP-36]
  ile R0, 0
  jf R0, __if_3272_end
  call __function_rand
  mov R2, R0
  mov R3, [BP-33]
  isub R3, 1
  imod R2, R3
  iadd R2, 1
  mov [BP-50], R2
  mov R2, 0
  mov [SP], R2
  mov R2, 0
  mov [SP+1], R2
  mov R2, [BP-50]
  mov [SP+2], R2
  call __function_mkenemy
  mov R1, R0
  mov [BP-42], R1
  mov R0, R1
  mov R2, [BP-44]
  mov [SP], R2
  mov R2, [BP-42]
  mov [SP+1], R2
  call __function_enqueue
  mov R1, R0
  mov [BP-44], R1
  mov R0, R1
__if_3295_start:
  mov R0, [BP-33]
  ilt R0, 32
  jf R0, __if_3295_else
  mov R0, 90
  mov [BP-36], R0
  jmp __if_3295_end
__if_3295_else:
  mov R0, 45
  mov [BP-36], R0
__if_3295_end:
__if_3272_end:
  mov R1, [BP-44]
  mov R0, [R1]
  mov [BP-42], R0
__while_3311_start:
__while_3311_continue:
  mov R0, [BP-42]
  ine R0, -1
  jf R0, __while_3311_end
__if_3316_start:
  mov R1, [BP-42]
  iadd R1, 2
  mov R0, [R1]
  ile R0, 0
  jf R0, __if_3316_else
  mov R0, [BP-32]
  iadd R0, 1
  mov [BP-32], R0
  mov R2, [BP-44]
  mov [SP], R2
  lea R2, [BP-42]
  mov [SP+1], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-44], R1
  mov R0, R1
  mov R2, [BP-42]
  mov [SP], R2
  call __function_rmnode
  mov R1, R0
  mov [BP-42], R1
  mov R0, R1
  mov R1, [BP-44]
  mov R0, [R1]
  mov [BP-42], R0
  jmp __if_3316_end
__if_3316_else:
  mov R1, [BP-42]
  mov R0, [R1]
  mov [BP-42], R0
__if_3316_end:
  jmp __while_3311_start
__while_3311_end:
__if_3344_start:
  mov R0, [BP-32]
  mov R1, [BP-33]
  ige R0, R1
  jf R0, __if_3344_end
  mov R0, [BP-33]
  imul R0, 2
  mov [BP-33], R0
__if_3344_end:
__if_3352_start:
  call __function_gamepad_up
  mov R1, R0
  igt R1, 0
  jf R1, __LogicalAnd_ShortCircuit_3357
  mov R2, [BP-35]
  ile R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_3357:
  mov R0, R1
  jf R0, __if_3352_end
  mov R0, 8
  mov [BP-35], R0
__if_3364_start:
  mov R0, [BP-40]
  jf R0, __LogicalAnd_ShortCircuit_3366
  mov R1, [BP-39]
  ige R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_3366:
  jf R0, __if_3364_else
  mov R0, [BP-39]
  mov R1, R0
  isub R1, 1
  mov [BP-39], R1
  jmp __if_3364_end
__if_3364_else:
__if_3373_start:
  mov R0, [BP-38]
  igt R0, 0
  jf R0, __if_3373_end
  mov R0, [BP-38]
  mov R1, R0
  isub R1, 1
  mov [BP-38], R1
__if_3373_end:
__if_3364_end:
__if_3380_start:
  mov R0, [BP-40]
  jf R0, __LogicalAnd_ShortCircuit_3382
  mov R1, [BP-39]
  ilt R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_3382:
  jf R0, __if_3380_end
  mov R0, 5
  mov [BP-39], R0
__if_3380_end:
__if_3352_end:
__if_3390_start:
  call __function_gamepad_down
  mov R1, R0
  igt R1, 0
  jf R1, __LogicalAnd_ShortCircuit_3395
  mov R2, [BP-35]
  ile R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_3395:
  mov R0, R1
  jf R0, __if_3390_end
  mov R0, 8
  mov [BP-35], R0
__if_3402_start:
  mov R0, [BP-40]
  jf R0, __LogicalAnd_ShortCircuit_3404
  mov R1, [BP-39]
  ilt R1, 6
  and R0, R1
__LogicalAnd_ShortCircuit_3404:
  jf R0, __if_3402_else
  mov R0, [BP-39]
  mov R1, R0
  iadd R1, 1
  mov [BP-39], R1
  jmp __if_3402_end
__if_3402_else:
__if_3411_start:
  mov R0, [BP-38]
  ilt R0, 10
  jf R0, __if_3411_end
  mov R0, [BP-38]
  mov R1, R0
  iadd R1, 1
  mov [BP-38], R1
__if_3411_end:
__if_3402_end:
__if_3418_start:
  mov R0, [BP-40]
  jf R0, __LogicalAnd_ShortCircuit_3420
  mov R1, [BP-39]
  igt R1, 5
  and R0, R1
__LogicalAnd_ShortCircuit_3420:
  jf R0, __if_3418_end
  mov R0, 0
  mov [BP-39], R0
__if_3418_end:
__if_3390_end:
__if_3428_start:
  call __function_gamepad_left
  mov R1, R0
  igt R1, 0
  jf R1, __LogicalAnd_ShortCircuit_3433
  mov R2, [BP-35]
  ile R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_3433:
  jf R1, __LogicalAnd_ShortCircuit_3437
  mov R2, [BP-37]
  igt R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_3437:
  mov R0, R1
  jf R0, __if_3428_end
  mov R0, 8
  mov [BP-35], R0
  mov R0, [BP-37]
  mov R1, R0
  isub R1, 1
  mov [BP-37], R1
__if_3428_end:
__if_3446_start:
  call __function_gamepad_right
  mov R1, R0
  igt R1, 0
  jf R1, __LogicalAnd_ShortCircuit_3451
  mov R2, [BP-35]
  ile R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_3451:
  jf R1, __LogicalAnd_ShortCircuit_3455
  mov R2, [BP-37]
  ile R2, 19
  and R1, R2
__LogicalAnd_ShortCircuit_3455:
  mov R0, R1
  jf R0, __if_3446_end
  mov R0, 8
  mov [BP-35], R0
  mov R0, [BP-37]
  mov R1, R0
  iadd R1, 1
  mov [BP-37], R1
__if_3446_end:
__if_3464_start:
  mov R0, [BP-37]
  ieq R0, 20
  jf R0, __if_3464_else
  mov R0, 1
  mov [BP-40], R0
__if_3472_start:
  mov R0, [BP-38]
  igt R0, 6
  jf R0, __if_3472_else
  mov R0, 0
  mov [BP-38], R0
  jmp __if_3472_end
__if_3472_else:
__if_3480_start:
  mov R0, [BP-38]
  ilt R0, 0
  jf R0, __if_3480_end
  mov R0, 5
  mov [BP-38], R0
__if_3480_end:
__if_3472_end:
  jmp __if_3464_end
__if_3464_else:
  mov R0, 0
  mov [BP-40], R0
__if_3464_end:
__if_3492_start:
  mov R0, [BP-40]
  jf R0, __if_3492_end
__if_3495_start:
  call __function_gamepad_button_b
  mov R1, R0
  igt R1, 0
  jf R1, __LogicalAnd_ShortCircuit_3501
  mov R3, [BP-46]
  iadd R3, 6
  mov R2, [R3]
  ieq R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_3501:
  mov R0, R1
  jf R0, __if_3495_end
  mov R2, [BP-37]
  mov [SP], R2
  mov R2, [BP-38]
  mov [SP+1], R2
  mov R2, [BP-39]
  iadd R2, 1
  mov [SP+2], R2
  call __function_mktower
  mov R1, R0
  mov [BP-42], R1
  mov R0, R1
  mov R2, [BP-46]
  mov [SP], R2
  mov R2, [BP-42]
  mov [SP+1], R2
  call __function_enqueue
  mov R1, R0
  mov [BP-46], R1
  mov R0, R1
  mov R0, 15
  mov [BP-35], R0
  mov R0, [BP-37]
  mov R1, R0
  isub R1, 1
  mov [BP-37], R1
__if_3495_end:
__if_3492_end:
  mov R1, [BP-46]
  mov R0, [R1]
  mov [BP-42], R0
__if_3527_start:
  mov R0, [BP-42]
  ine R0, -1
  jf R0, __if_3527_end
  mov R0, [BP-37]
  cif R0
  mov R1, [BP-42]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-38]
  cif R0
  mov R1, [BP-42]
  iadd R1, 4
  mov [R1], R0
__if_3527_end:
  mov R0, 1
  mov [BP-41], R0
  mov R1, [BP-46]
  mov R0, [R1]
  mov [BP-43], R0
  mov R1, [BP-45]
  mov R0, [R1]
  mov [BP-42], R0
__if_3551_start:
  mov R1, [BP-43]
  iadd R1, 4
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_3558
  mov R2, [BP-43]
  iadd R2, 3
  mov R1, [R2]
  fle R1, 5.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3558:
  jf R0, __if_3551_else
  mov R0, 0
  mov [BP-41], R0
  jmp __if_3551_end
__if_3551_else:
__if_3565_start:
  mov R1, [BP-43]
  iadd R1, 3
  mov R0, [R1]
  feq R0, 5.000000
  jf R0, __LogicalAnd_ShortCircuit_3572
  mov R2, [BP-43]
  iadd R2, 4
  mov R1, [R2]
  fle R1, 5.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3572:
  jf R0, __if_3565_else
  mov R0, 0
  mov [BP-41], R0
  jmp __if_3565_end
__if_3565_else:
__if_3579_start:
  mov R1, [BP-43]
  iadd R1, 4
  mov R0, [R1]
  feq R0, 5.000000
  jf R0, __LogicalAnd_ShortCircuit_3586
  mov R2, [BP-43]
  iadd R2, 3
  mov R1, [R2]
  fge R1, 5.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3586:
  jf R0, __LogicalAnd_ShortCircuit_3591
  mov R2, [BP-43]
  iadd R2, 3
  mov R1, [R2]
  fle R1, 8.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3591:
  jf R0, __if_3579_else
  mov R0, 0
  mov [BP-41], R0
  jmp __if_3579_end
__if_3579_else:
__if_3598_start:
  mov R1, [BP-43]
  iadd R1, 3
  mov R0, [R1]
  feq R0, 8.000000
  jf R0, __LogicalAnd_ShortCircuit_3605
  mov R2, [BP-43]
  iadd R2, 4
  mov R1, [R2]
  fge R1, 5.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3605:
  jf R0, __LogicalAnd_ShortCircuit_3610
  mov R2, [BP-43]
  iadd R2, 4
  mov R1, [R2]
  fle R1, 8.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3610:
  jf R0, __if_3598_else
  mov R0, 0
  mov [BP-41], R0
  jmp __if_3598_end
__if_3598_else:
__if_3617_start:
  mov R1, [BP-43]
  iadd R1, 4
  mov R0, [R1]
  feq R0, 8.000000
  jf R0, __LogicalAnd_ShortCircuit_3624
  mov R2, [BP-43]
  iadd R2, 3
  mov R1, [R2]
  fge R1, 8.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3624:
  jf R0, __LogicalAnd_ShortCircuit_3629
  mov R2, [BP-43]
  iadd R2, 3
  mov R1, [R2]
  fle R1, 10.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3629:
  jf R0, __if_3617_else
  mov R0, 0
  mov [BP-41], R0
  jmp __if_3617_end
__if_3617_else:
__if_3636_start:
  mov R1, [BP-43]
  iadd R1, 3
  mov R0, [R1]
  feq R0, 10.000000
  jf R0, __LogicalAnd_ShortCircuit_3643
  mov R2, [BP-43]
  iadd R2, 4
  mov R1, [R2]
  fge R1, 5.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3643:
  jf R0, __LogicalAnd_ShortCircuit_3648
  mov R2, [BP-43]
  iadd R2, 4
  mov R1, [R2]
  fle R1, 8.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3648:
  jf R0, __if_3636_else
  mov R0, 0
  mov [BP-41], R0
  jmp __if_3636_end
__if_3636_else:
__if_3655_start:
  mov R1, [BP-43]
  iadd R1, 4
  mov R0, [R1]
  feq R0, 5.000000
  jf R0, __LogicalAnd_ShortCircuit_3662
  mov R2, [BP-43]
  iadd R2, 3
  mov R1, [R2]
  fge R1, 10.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3662:
  jf R0, __LogicalAnd_ShortCircuit_3667
  mov R2, [BP-43]
  iadd R2, 3
  mov R1, [R2]
  fle R1, 18.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3667:
  jf R0, __if_3655_else
  mov R0, 0
  mov [BP-41], R0
  jmp __if_3655_end
__if_3655_else:
__if_3674_start:
  mov R1, [BP-43]
  iadd R1, 3
  mov R0, [R1]
  feq R0, 18.000000
  jf R0, __LogicalAnd_ShortCircuit_3681
  mov R2, [BP-43]
  iadd R2, 4
  mov R1, [R2]
  fge R1, 5.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3681:
  jf R0, __LogicalAnd_ShortCircuit_3686
  mov R2, [BP-43]
  iadd R2, 4
  mov R1, [R2]
  fle R1, 8.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3686:
  jf R0, __if_3674_else
  mov R0, 0
  mov [BP-41], R0
  jmp __if_3674_end
__if_3674_else:
__if_3693_start:
  mov R1, [BP-43]
  iadd R1, 4
  mov R0, [R1]
  feq R0, 8.000000
  jf R0, __LogicalAnd_ShortCircuit_3700
  mov R2, [BP-43]
  iadd R2, 3
  mov R1, [R2]
  fge R1, 18.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3700:
  jf R0, __LogicalAnd_ShortCircuit_3705
  mov R2, [BP-43]
  iadd R2, 3
  mov R1, [R2]
  fle R1, 19.000000
  and R0, R1
__LogicalAnd_ShortCircuit_3705:
  jf R0, __if_3693_else
  mov R0, 0
  mov [BP-41], R0
  jmp __if_3693_end
__if_3693_else:
__while_3713_start:
__while_3713_continue:
  mov R0, [BP-42]
  ine R0, -1
  jf R0, __while_3713_end
__if_3718_start:
  mov R1, [BP-42]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-37]
  cif R1
  feq R0, R1
  jf R0, __if_3718_end
__if_3724_start:
  mov R1, [BP-42]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-38]
  cif R1
  feq R0, R1
  jf R0, __if_3724_end
  mov R0, 0
  mov [BP-41], R0
__if_3724_end:
__if_3718_end:
  mov R1, [BP-42]
  mov R0, [R1]
  mov [BP-42], R0
  jmp __while_3713_start
__while_3713_end:
__if_3693_end:
__if_3674_end:
__if_3655_end:
__if_3636_end:
__if_3617_end:
__if_3598_end:
__if_3579_end:
__if_3565_end:
__if_3551_end:
__if_3737_start:
  mov R0, [BP-40]
  bnot R0
  jf R0, __if_3737_end
__if_3741_start:
  call __function_gamepad_button_b
  mov R1, R0
  igt R1, 0
  jf R1, __LogicalAnd_ShortCircuit_3747
  mov R3, [BP-46]
  iadd R3, 6
  mov R2, [R3]
  ieq R2, 1
  and R1, R2
__LogicalAnd_ShortCircuit_3747:
  jf R1, __LogicalAnd_ShortCircuit_3751
  mov R2, [BP-35]
  ile R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_3751:
  jf R1, __LogicalAnd_ShortCircuit_3755
  mov R2, [BP-41]
  and R1, R2
__LogicalAnd_ShortCircuit_3755:
  mov R0, R1
  jf R0, __if_3741_end
__if_3757_start:
  mov R1, [BP-43]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 1
  jf R0, __LogicalAnd_ShortCircuit_3763
  mov R1, [BP-34]
  ige R1, 50
  and R0, R1
__LogicalAnd_ShortCircuit_3763:
  jf R0, __if_3757_else
  mov R1, [BP-46]
  mov R0, [R1]
  mov [BP-43], R0
  mov R2, [BP-46]
  mov [SP], R2
  lea R2, [BP-43]
  mov [SP+1], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-46], R1
  mov R0, R1
  mov R0, [BP-37]
  cif R0
  mov R1, [BP-43]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-38]
  cif R0
  mov R1, [BP-43]
  iadd R1, 4
  mov [R1], R0
  mov R2, [BP-45]
  mov [SP], R2
  mov R2, [BP-43]
  mov [SP+1], R2
  call __function_enqueue
  mov R1, R0
  mov [BP-45], R1
  mov R0, R1
  mov R0, [BP-34]
  isub R0, 50
  mov [BP-34], R0
  jmp __if_3757_end
__if_3757_else:
__if_3793_start:
  mov R1, [BP-43]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_3799
  mov R1, [BP-34]
  ige R1, 30
  and R0, R1
__LogicalAnd_ShortCircuit_3799:
  jf R0, __if_3793_else
  mov R1, [BP-46]
  mov R0, [R1]
  mov [BP-43], R0
  mov R2, [BP-46]
  mov [SP], R2
  lea R2, [BP-43]
  mov [SP+1], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-46], R1
  mov R0, R1
  mov R0, [BP-37]
  cif R0
  mov R1, [BP-43]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-38]
  cif R0
  mov R1, [BP-43]
  iadd R1, 4
  mov [R1], R0
  mov R2, [BP-45]
  mov [SP], R2
  mov R2, [BP-43]
  mov [SP+1], R2
  call __function_enqueue
  mov R1, R0
  mov [BP-45], R1
  mov R0, R1
  mov R0, [BP-34]
  isub R0, 30
  mov [BP-34], R0
  jmp __if_3793_end
__if_3793_else:
__if_3829_start:
  mov R1, [BP-43]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 3
  jf R0, __LogicalAnd_ShortCircuit_3835
  mov R1, [BP-34]
  ige R1, 75
  and R0, R1
__LogicalAnd_ShortCircuit_3835:
  jf R0, __if_3829_else
  mov R1, [BP-46]
  mov R0, [R1]
  mov [BP-43], R0
  mov R2, [BP-46]
  mov [SP], R2
  lea R2, [BP-43]
  mov [SP+1], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-46], R1
  mov R0, R1
  mov R0, [BP-37]
  cif R0
  mov R1, [BP-43]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-38]
  cif R0
  mov R1, [BP-43]
  iadd R1, 4
  mov [R1], R0
  mov R2, [BP-45]
  mov [SP], R2
  mov R2, [BP-43]
  mov [SP+1], R2
  call __function_enqueue
  mov R1, R0
  mov [BP-45], R1
  mov R0, R1
  mov R0, [BP-34]
  isub R0, 75
  mov [BP-34], R0
  jmp __if_3829_end
__if_3829_else:
__if_3865_start:
  mov R1, [BP-43]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 4
  jf R0, __LogicalAnd_ShortCircuit_3871
  mov R1, [BP-34]
  ige R1, 150
  and R0, R1
__LogicalAnd_ShortCircuit_3871:
  jf R0, __if_3865_else
  mov R1, [BP-46]
  mov R0, [R1]
  mov [BP-43], R0
  mov R2, [BP-46]
  mov [SP], R2
  lea R2, [BP-43]
  mov [SP+1], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-46], R1
  mov R0, R1
  mov R0, [BP-37]
  cif R0
  mov R1, [BP-43]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-38]
  cif R0
  mov R1, [BP-43]
  iadd R1, 4
  mov [R1], R0
  mov R2, [BP-45]
  mov [SP], R2
  mov R2, [BP-43]
  mov [SP+1], R2
  call __function_enqueue
  mov R1, R0
  mov [BP-45], R1
  mov R0, R1
  mov R0, [BP-34]
  isub R0, 150
  mov [BP-34], R0
  jmp __if_3865_end
__if_3865_else:
__if_3901_start:
  mov R1, [BP-43]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 5
  jf R0, __LogicalAnd_ShortCircuit_3907
  mov R1, [BP-34]
  ige R1, 125
  and R0, R1
__LogicalAnd_ShortCircuit_3907:
  jf R0, __if_3901_else
  mov R1, [BP-46]
  mov R0, [R1]
  mov [BP-43], R0
  mov R2, [BP-46]
  mov [SP], R2
  lea R2, [BP-43]
  mov [SP+1], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-46], R1
  mov R0, R1
  mov R0, [BP-37]
  cif R0
  mov R1, [BP-43]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-38]
  cif R0
  mov R1, [BP-43]
  iadd R1, 4
  mov [R1], R0
  mov R2, [BP-45]
  mov [SP], R2
  mov R2, [BP-43]
  mov [SP+1], R2
  call __function_enqueue
  mov R1, R0
  mov [BP-45], R1
  mov R0, R1
  mov R0, [BP-34]
  isub R0, 125
  mov [BP-34], R0
  jmp __if_3901_end
__if_3901_else:
__if_3937_start:
  mov R1, [BP-43]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 6
  jf R0, __LogicalAnd_ShortCircuit_3943
  mov R1, [BP-34]
  ige R1, 50
  and R0, R1
__LogicalAnd_ShortCircuit_3943:
  jf R0, __if_3937_end
  mov R1, [BP-46]
  mov R0, [R1]
  mov [BP-43], R0
  mov R2, [BP-46]
  mov [SP], R2
  lea R2, [BP-43]
  mov [SP+1], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-46], R1
  mov R0, R1
  mov R0, [BP-37]
  cif R0
  mov R1, [BP-43]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-38]
  cif R0
  mov R1, [BP-43]
  iadd R1, 4
  mov [R1], R0
  mov R2, [BP-45]
  mov [SP], R2
  mov R2, [BP-43]
  mov [SP+1], R2
  call __function_enqueue
  mov R1, R0
  mov [BP-45], R1
  mov R0, R1
  mov R0, [BP-34]
  isub R0, 50
  mov [BP-34], R0
__if_3937_end:
__if_3901_end:
__if_3865_end:
__if_3829_end:
__if_3793_end:
__if_3757_end:
__if_3741_end:
__if_3737_end:
__if_3973_start:
  call __function_gamepad_button_a
  mov R1, R0
  igt R1, 0
  jf R1, __LogicalAnd_ShortCircuit_3978
  mov R2, [BP-35]
  ile R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_3978:
  mov R0, R1
  jf R0, __if_3973_end
  mov R1, [BP-45]
  mov R0, [R1]
  mov [BP-42], R0
__while_3986_start:
__while_3986_continue:
  mov R0, [BP-42]
  ine R0, -1
  jf R0, __while_3986_end
__if_3991_start:
  mov R1, [BP-42]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-37]
  cif R1
  feq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_3998
  mov R2, [BP-42]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-38]
  cif R2
  feq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3998:
  jf R0, __LogicalAnd_ShortCircuit_4003
  mov R2, [BP-42]
  iadd R2, 8
  mov R1, [R2]
  ilt R1, 3
  and R0, R1
__LogicalAnd_ShortCircuit_4003:
  jf R0, __if_3991_end
__if_4007_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_4007_else
__if_4013_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __LogicalAnd_ShortCircuit_4019
  mov R1, [BP-34]
  ige R1, 100
  and R0, R1
__LogicalAnd_ShortCircuit_4019:
  jf R0, __if_4013_else
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 100
  mov [BP-34], R0
  jmp __if_4013_end
__if_4013_else:
__if_4029_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_4035
  mov R1, [BP-34]
  ige R1, 300
  and R0, R1
__LogicalAnd_ShortCircuit_4035:
  jf R0, __if_4029_end
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 300
  mov [BP-34], R0
__if_4029_end:
__if_4013_end:
  jmp __if_4007_end
__if_4007_else:
__if_4045_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_4045_else
__if_4051_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __LogicalAnd_ShortCircuit_4057
  mov R1, [BP-34]
  ige R1, 50
  and R0, R1
__LogicalAnd_ShortCircuit_4057:
  jf R0, __if_4051_else
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 50
  mov [BP-34], R0
  jmp __if_4051_end
__if_4051_else:
__if_4067_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_4073
  mov R1, [BP-34]
  ige R1, 200
  and R0, R1
__LogicalAnd_ShortCircuit_4073:
  jf R0, __if_4067_end
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 200
  mov [BP-34], R0
__if_4067_end:
__if_4051_end:
  jmp __if_4045_end
__if_4045_else:
__if_4083_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_4083_else
__if_4089_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __LogicalAnd_ShortCircuit_4095
  mov R1, [BP-34]
  ige R1, 150
  and R0, R1
__LogicalAnd_ShortCircuit_4095:
  jf R0, __if_4089_else
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 150
  mov [BP-34], R0
  jmp __if_4089_end
__if_4089_else:
__if_4105_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_4111
  mov R1, [BP-34]
  ige R1, 750
  and R0, R1
__LogicalAnd_ShortCircuit_4111:
  jf R0, __if_4105_end
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 500
  mov [BP-34], R0
__if_4105_end:
__if_4089_end:
  jmp __if_4083_end
__if_4083_else:
__if_4121_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_4121_else
__if_4127_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __LogicalAnd_ShortCircuit_4133
  mov R1, [BP-34]
  ige R1, 150
  and R0, R1
__LogicalAnd_ShortCircuit_4133:
  jf R0, __if_4127_else
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 150
  mov [BP-34], R0
  jmp __if_4127_end
__if_4127_else:
__if_4143_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_4149
  mov R1, [BP-34]
  ige R1, 1000
  and R0, R1
__LogicalAnd_ShortCircuit_4149:
  jf R0, __if_4143_end
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 1000
  mov [BP-34], R0
__if_4143_end:
__if_4127_end:
  jmp __if_4121_end
__if_4121_else:
__if_4159_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_4159_else
__if_4165_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __LogicalAnd_ShortCircuit_4171
  mov R1, [BP-34]
  ige R1, 150
  and R0, R1
__LogicalAnd_ShortCircuit_4171:
  jf R0, __if_4165_else
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 150
  mov [BP-34], R0
  jmp __if_4165_end
__if_4165_else:
__if_4181_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_4187
  mov R1, [BP-34]
  ige R1, 300
  and R0, R1
__LogicalAnd_ShortCircuit_4187:
  jf R0, __if_4181_end
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 300
  mov [BP-34], R0
__if_4181_end:
__if_4165_end:
  jmp __if_4159_end
__if_4159_else:
__if_4197_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_4197_end
__if_4203_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __LogicalAnd_ShortCircuit_4209
  mov R1, [BP-34]
  ige R1, 100
  and R0, R1
__LogicalAnd_ShortCircuit_4209:
  jf R0, __if_4203_else
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 100
  mov [BP-34], R0
  jmp __if_4203_end
__if_4203_else:
__if_4219_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_4225
  mov R1, [BP-34]
  ige R1, 200
  and R0, R1
__LogicalAnd_ShortCircuit_4225:
  jf R0, __if_4219_end
  mov R2, [BP-42]
  iadd R2, 8
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP-34]
  isub R0, 200
  mov [BP-34], R0
__if_4219_end:
__if_4203_end:
__if_4197_end:
__if_4159_end:
__if_4121_end:
__if_4083_end:
__if_4045_end:
__if_4007_end:
__if_3991_end:
  mov R1, [BP-42]
  mov R0, [R1]
  mov [BP-42], R0
  jmp __while_3986_start
__while_3986_end:
  mov R0, 15
  mov [BP-35], R0
__if_3973_end:
  mov R1, [BP-45]
  mov R0, [R1]
  mov [BP-42], R0
  mov R1, [BP-44]
  mov R0, [R1]
  mov [BP-43], R0
__while_4252_start:
__while_4252_continue:
  mov R0, [BP-42]
  ine R0, -1
  jf R0, __while_4252_end
  mov R4, [BP-42]
  iadd R4, 3
  mov R3, [R4]
  mov R5, [BP-43]
  iadd R5, 3
  mov R4, [R5]
  fdiv R4, 4.000000
  fsub R3, R4
  mov [SP], R3
  mov R3, 2
  cif R3
  mov [SP+1], R3
  call __function_pow
  mov R2, R0
  mov R5, [BP-42]
  iadd R5, 4
  mov R4, [R5]
  mov R6, [BP-43]
  iadd R6, 4
  mov R5, [R6]
  fdiv R5, 4.000000
  fsub R4, R5
  mov [SP], R4
  mov R4, 2
  cif R4
  mov [SP+1], R4
  call __function_pow
  mov R3, R0
  fadd R2, R3
  mov [BP-50], R2
  mov R2, [BP-50]
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  mov [BP-48], R1
  mov R0, R1
__if_4283_start:
  mov R0, [BP-48]
  mov R2, [BP-42]
  iadd R2, 9
  mov R1, [R2]
  cif R1
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_4290
  mov R2, [BP-42]
  iadd R2, 7
  mov R1, [R2]
  ile R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_4290:
  jf R0, __if_4283_end
__if_4294_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_4294_end
__if_4300_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_4300_else
__if_4306_start:
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  idiv R1, 2
  igt R0, R1
  jf R0, __if_4306_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  idiv R1, 2
  isub R0, R1
  imul R0, 2
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-33]
  idiv R1, 2
  iadd R0, R1
  mov [BP-34], R0
  jmp __if_4306_end
__if_4306_else:
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  imul R0, 2
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
__if_4306_end:
__if_4336_start:
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  ige R0, R1
  jf R0, __if_4336_end
  mov R0, 0
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-33]
  idiv R1, 2
  iadd R0, R1
  mov [BP-34], R0
__if_4336_end:
  mov R0, 120
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4300_end
__if_4300_else:
__if_4355_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_4355_else
__if_4361_start:
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  idiv R1, 2
  igt R0, R1
  jf R0, __if_4361_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  idiv R1, 2
  isub R0, R1
  imul R0, 2
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-33]
  idiv R1, 2
  iadd R0, R1
  mov [BP-34], R0
  jmp __if_4361_end
__if_4361_else:
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  imul R0, 2
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
__if_4361_end:
__if_4391_start:
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  ige R0, R1
  jf R0, __if_4391_end
  mov R0, 0
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-33]
  idiv R1, 2
  iadd R0, R1
  mov [BP-34], R0
__if_4391_end:
  mov R0, 90
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4355_end
__if_4355_else:
__if_4410_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_4410_end
__if_4416_start:
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  idiv R1, 2
  igt R0, R1
  jf R0, __if_4416_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  idiv R1, 2
  isub R0, R1
  imul R0, 2
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-33]
  idiv R1, 2
  iadd R0, R1
  mov [BP-34], R0
  jmp __if_4416_end
__if_4416_else:
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  imul R0, 2
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
__if_4416_end:
__if_4446_start:
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  ige R0, R1
  jf R0, __if_4446_end
  mov R0, 0
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-33]
  idiv R1, 2
  iadd R0, R1
  mov [BP-34], R0
__if_4446_end:
  mov R0, 60
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
__if_4410_end:
__if_4355_end:
__if_4300_end:
__if_4294_end:
__if_4465_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_4465_end
__if_4471_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_4471_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  idiv R0, 2
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  iadd R0, 1
  mov [BP-34], R0
  mov R0, 45
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4471_end
__if_4471_else:
__if_4488_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_4488_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  idiv R0, 4
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  iadd R0, 3
  mov [BP-34], R0
  mov R0, 37
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4488_end
__if_4488_else:
__if_4505_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_4505_end
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  idiv R0, 16
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  iadd R0, 15
  mov [BP-34], R0
  mov R0, 30
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
__if_4505_end:
__if_4488_end:
__if_4471_end:
__if_4465_end:
__if_4522_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_4522_end
__if_4528_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_4528_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-49], R0
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  isub R1, 1
  mov R2, [BP-33]
  idiv R2, 2
  isub R1, R2
  mov R2, [BP-33]
  idiv R2, 8
  isub R1, R2
  and R0, R1
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-49]
  mov R3, [BP-43]
  iadd R3, 2
  mov R2, [R3]
  isub R1, R2
  iadd R0, R1
  mov [BP-34], R0
  mov R0, 150
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4528_end
__if_4528_else:
__if_4567_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_4567_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-49], R0
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  isub R1, 1
  mov R2, [BP-33]
  idiv R2, 2
  isub R1, R2
  mov R2, [BP-33]
  idiv R2, 8
  isub R1, R2
  mov R2, [BP-33]
  idiv R2, 16
  isub R1, R2
  mov R2, [BP-33]
  idiv R2, 32
  isub R1, R2
  and R0, R1
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-49]
  mov R3, [BP-43]
  iadd R3, 2
  mov R2, [R3]
  isub R1, R2
  iadd R0, R1
  mov [BP-34], R0
  mov R0, 120
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4567_end
__if_4567_else:
__if_4614_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_4614_end
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-49], R0
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  and R0, 1
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-49]
  mov R3, [BP-43]
  iadd R3, 2
  mov R2, [R3]
  isub R1, R2
  iadd R0, R1
  mov [BP-34], R0
  mov R0, 90
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
__if_4614_end:
__if_4567_end:
__if_4528_end:
__if_4522_end:
__if_4642_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_4642_end
__if_4648_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_4648_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  idiv R1, 2
  or R0, R1
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, 120
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4648_end
__if_4648_else:
__if_4667_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_4667_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  idiv R1, 2
  mov R2, [BP-33]
  idiv R2, 4
  iadd R1, R2
  mov R2, [BP-33]
  idiv R2, 8
  iadd R1, R2
  mov R2, [BP-33]
  idiv R2, 16
  iadd R1, R2
  or R0, R1
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, 120
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4667_end
__if_4667_else:
__if_4698_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_4698_end
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  isub R1, 1
  or R0, R1
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, 120
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
__if_4698_end:
__if_4667_end:
__if_4648_end:
__if_4642_end:
__if_4717_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_4717_end
__if_4723_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_4723_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-49], R0
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  isub R1, 1
  mov R2, [BP-33]
  idiv R2, 2
  isub R1, R2
  mov R2, [BP-33]
  idiv R2, 4
  isub R1, R2
  xor R0, R1
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-49]
  mov R3, [BP-43]
  iadd R3, 2
  mov R2, [R3]
  isub R1, R2
  iadd R0, R1
  mov [BP-34], R0
  mov R0, 120
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4723_end
__if_4723_else:
__if_4762_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_4762_else
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-49], R0
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  isub R1, 1
  mov R2, [BP-33]
  idiv R2, 2
  isub R1, R2
  mov R2, [BP-33]
  idiv R2, 4
  isub R1, R2
  mov R2, [BP-33]
  idiv R2, 8
  isub R1, R2
  mov R2, [BP-33]
  idiv R2, 16
  isub R1, R2
  xor R0, R1
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-49]
  mov R3, [BP-43]
  iadd R3, 2
  mov R2, [R3]
  isub R1, R2
  iadd R0, R1
  mov [BP-34], R0
  mov R0, 90
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4762_end
__if_4762_else:
__if_4809_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_4809_end
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-49], R0
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP-43]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 1
  xor R0, R1
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-34]
  mov R1, [BP-49]
  mov R3, [BP-43]
  iadd R3, 2
  mov R2, [R3]
  isub R1, R2
  iadd R0, R1
  mov [BP-34], R0
  mov R0, 45
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
__if_4809_end:
__if_4762_end:
__if_4723_end:
__if_4717_end:
__if_4841_start:
  mov R1, [BP-42]
  iadd R1, 6
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_4841_end
  mov R1, [BP-43]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-33]
  isub R1, 1
  xor R0, R1
  mov R1, [BP-43]
  iadd R1, 2
  mov [R1], R0
__if_4856_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_4856_else
  mov R0, 120
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4856_end
__if_4856_else:
__if_4866_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_4866_else
  mov R0, 90
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
  jmp __if_4866_end
__if_4866_else:
__if_4876_start:
  mov R1, [BP-42]
  iadd R1, 8
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_4876_end
  mov R0, 60
  mov R1, [BP-42]
  iadd R1, 7
  mov [R1], R0
__if_4876_end:
__if_4866_end:
__if_4856_end:
__if_4841_end:
__if_4283_end:
  mov R1, [BP-42]
  mov R0, [R1]
  mov [BP-42], R0
  jmp __while_4252_start
__while_4252_end:
  mov R1, 0
  mov [SP], R1
  call __function_select_texture
  mov R1, 0
  mov [SP], R1
  call __function_select_region
  mov R1, 0
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  call __function_draw_region_at
__if_4897_start:
  call __function_get_frame_counter
  mov R1, R0
  imod R1, 30
  igt R1, 15
  mov R0, R1
  jf R0, __if_4897_else
  mov R1, 1
  mov [SP], R1
  call __function_select_texture
  mov R1, 1
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-37]
  imul R1, 32
  mov [SP], R1
  mov R1, [BP-38]
  imul R1, 32
  iadd R1, 4
  mov [SP+1], R1
  call __function_draw_region_at
  jmp __if_4897_end
__if_4897_else:
  mov R1, 1
  mov [SP], R1
  call __function_select_texture
  mov R1, 2
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-37]
  imul R1, 32
  mov [SP], R1
  mov R1, [BP-38]
  imul R1, 32
  iadd R1, 4
  mov [SP+1], R1
  call __function_draw_region_at
__if_4897_end:
  mov R1, 2
  mov [SP], R1
  call __function_select_texture
  mov R3, [BP-46]
  mov R2, [R3]
  iadd R2, 6
  mov R1, [R2]
  isub R1, 1
  imul R1, 3
  iadd R1, 4
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-37]
  imul R1, 32
  mov [SP], R1
  mov R1, [BP-38]
  imul R1, 32
  isub R1, 4
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, [BP-45]
  mov R0, [R1]
  mov [BP-42], R0
__while_4959_start:
__while_4959_continue:
  mov R0, [BP-42]
  ine R0, -1
  jf R0, __while_4959_end
  mov R1, 2
  mov [SP], R1
  call __function_select_texture
  mov R2, [BP-42]
  iadd R2, 6
  mov R1, [R2]
  isub R1, 1
  imul R1, 3
  iadd R1, 4
  mov R3, [BP-42]
  iadd R3, 8
  mov R2, [R3]
  iadd R1, R2
  isub R1, 1
  mov [SP], R1
  call __function_select_region
  mov R2, [BP-42]
  iadd R2, 3
  mov R1, [R2]
  fmul R1, 32.000000
  cfi R1
  mov [SP], R1
  mov R2, [BP-42]
  iadd R2, 4
  mov R1, [R2]
  fmul R1, 32.000000
  fadd R1, 2.000000
  cfi R1
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, [BP-42]
  mov R0, [R1]
  mov [BP-42], R0
  jmp __while_4959_start
__while_4959_end:
  mov R1, [BP-44]
  mov R0, [R1]
  mov [BP-42], R0
__while_5000_start:
__while_5000_continue:
  mov R0, [BP-42]
  ine R0, -1
  jf R0, __while_5000_end
__if_5005_start:
  mov R1, [BP-42]
  iadd R1, 2
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_5005_end
  mov R2, [BP-42]
  iadd R2, 2
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R2, [BP-42]
  iadd R2, 3
  mov R1, [R2]
  fmul R1, 8.000000
  cfi R1
  mov [SP], R1
  mov R2, [BP-42]
  iadd R2, 4
  mov R1, [R2]
  fmul R1, 8.000000
  fadd R1, 10.000000
  cfi R1
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_print_at
__if_5005_end:
  mov R1, [BP-42]
  mov R0, [R1]
  mov [BP-42], R0
  jmp __while_5000_start
__while_5000_end:
__if_5032_start:
  mov R0, [BP-40]
  jf R0, __if_5032_end
  mov R1, 2
  mov [SP], R1
  call __function_select_texture
  mov R1, [BP-39]
  imul R1, 3
  iadd R1, 4
  mov [SP], R1
  call __function_select_region
  mov R1, 2
  cif R1
  mov [SP], R1
  mov R1, 2
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, 576
  mov [SP], R1
  mov R1, 148
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__if_5050_start:
  mov R0, [BP-39]
  igt R0, 0
  jf R0, __if_5050_else
  mov R1, 2
  mov [SP], R1
  call __function_select_texture
  mov R1, [BP-39]
  isub R1, 1
  imul R1, 3
  iadd R1, 4
  mov [SP], R1
  call __function_select_region
  jmp __if_5050_end
__if_5050_else:
  mov R1, 2
  mov [SP], R1
  call __function_select_texture
  mov R1, 19
  mov [SP], R1
  call __function_select_region
__if_5050_end:
  mov R1, 598
  mov [SP], R1
  mov R1, 116
  mov [SP+1], R1
  call __function_draw_region_at
__if_5077_start:
  mov R0, [BP-39]
  ilt R0, 5
  jf R0, __if_5077_else
  mov R1, 2
  mov [SP], R1
  call __function_select_texture
  mov R1, [BP-39]
  iadd R1, 1
  imul R1, 3
  iadd R1, 4
  mov [SP], R1
  call __function_select_region
  jmp __if_5077_end
__if_5077_else:
  mov R1, 2
  mov [SP], R1
  call __function_select_texture
  mov R1, 4
  mov [SP], R1
  call __function_select_region
__if_5077_end:
  mov R1, 598
  mov [SP], R1
  mov R1, 212
  mov [SP+1], R1
  call __function_draw_region_at
__if_5102_start:
  mov R0, [BP-39]
  ieq R0, 0
  jf R0, __if_5102_else
  mov R1, 3
  mov [SP], R1
  call __function_select_texture
  mov R1, 25
  mov [SP], R1
  call __function_select_region
  mov R1, 465
  mov [SP], R1
  mov R1, 250
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 475
  mov [SP], R1
  mov R1, 260
  mov [SP+1], R1
  mov R1, __literal_string_5117
  mov [SP+2], R1
  call __function_print_at
  mov R1, 475
  mov [SP], R1
  mov R1, 280
  mov [SP+1], R1
  mov R1, __literal_string_5121
  mov [SP+2], R1
  call __function_print_at
  mov R1, 475
  mov [SP], R1
  mov R1, 300
  mov [SP+1], R1
  mov R1, __literal_string_5125
  mov [SP+2], R1
  call __function_print_at
  jmp __if_5102_end
__if_5102_else:
__if_5126_start:
  mov R0, [BP-39]
  ieq R0, 1
  jf R0, __if_5126_else
  mov R1, 3
  mov [SP], R1
  call __function_select_texture
  mov R1, 25
  mov [SP], R1
  call __function_select_region
  mov R1, 455
  mov [SP], R1
  mov R1, 250
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 465
  mov [SP], R1
  mov R1, 260
  mov [SP+1], R1
  mov R1, __literal_string_5141
  mov [SP+2], R1
  call __function_print_at
  mov R1, 465
  mov [SP], R1
  mov R1, 280
  mov [SP+1], R1
  mov R1, __literal_string_5145
  mov [SP+2], R1
  call __function_print_at
  mov R1, 465
  mov [SP], R1
  mov R1, 300
  mov [SP+1], R1
  mov R1, __literal_string_5149
  mov [SP+2], R1
  call __function_print_at
  jmp __if_5126_end
__if_5126_else:
__if_5150_start:
  mov R0, [BP-39]
  ieq R0, 2
  jf R0, __if_5150_else
  mov R1, 3
  mov [SP], R1
  call __function_select_texture
  mov R1, 25
  mov [SP], R1
  call __function_select_region
  mov R1, 465
  mov [SP], R1
  mov R1, 250
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 475
  mov [SP], R1
  mov R1, 260
  mov [SP+1], R1
  mov R1, __literal_string_5165
  mov [SP+2], R1
  call __function_print_at
  mov R1, 475
  mov [SP], R1
  mov R1, 280
  mov [SP+1], R1
  mov R1, __literal_string_5169
  mov [SP+2], R1
  call __function_print_at
  mov R1, 475
  mov [SP], R1
  mov R1, 300
  mov [SP+1], R1
  mov R1, __literal_string_5173
  mov [SP+2], R1
  call __function_print_at
  jmp __if_5150_end
__if_5150_else:
__if_5174_start:
  mov R0, [BP-39]
  ieq R0, 3
  jf R0, __if_5174_else
  mov R1, 3
  mov [SP], R1
  call __function_select_texture
  mov R1, 25
  mov [SP], R1
  call __function_select_region
  mov R1, 475
  mov [SP], R1
  mov R1, 250
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 485
  mov [SP], R1
  mov R1, 260
  mov [SP+1], R1
  mov R1, __literal_string_5189
  mov [SP+2], R1
  call __function_print_at
  mov R1, 485
  mov [SP], R1
  mov R1, 280
  mov [SP+1], R1
  mov R1, __literal_string_5193
  mov [SP+2], R1
  call __function_print_at
  mov R1, 485
  mov [SP], R1
  mov R1, 300
  mov [SP+1], R1
  mov R1, __literal_string_5197
  mov [SP+2], R1
  call __function_print_at
  jmp __if_5174_end
__if_5174_else:
__if_5198_start:
  mov R0, [BP-39]
  ieq R0, 4
  jf R0, __if_5198_else
  mov R1, 3
  mov [SP], R1
  call __function_select_texture
  mov R1, 25
  mov [SP], R1
  call __function_select_region
  mov R1, 465
  mov [SP], R1
  mov R1, 250
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 475
  mov [SP], R1
  mov R1, 260
  mov [SP+1], R1
  mov R1, __literal_string_5213
  mov [SP+2], R1
  call __function_print_at
  mov R1, 475
  mov [SP], R1
  mov R1, 280
  mov [SP+1], R1
  mov R1, __literal_string_5217
  mov [SP+2], R1
  call __function_print_at
  mov R1, 475
  mov [SP], R1
  mov R1, 300
  mov [SP+1], R1
  mov R1, __literal_string_5221
  mov [SP+2], R1
  call __function_print_at
  jmp __if_5198_end
__if_5198_else:
__if_5222_start:
  mov R0, [BP-39]
  ieq R0, 5
  jf R0, __if_5222_end
  mov R1, 3
  mov [SP], R1
  call __function_select_texture
  mov R1, 25
  mov [SP], R1
  call __function_select_region
  mov R1, 505
  mov [SP], R1
  mov R1, 250
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 515
  mov [SP], R1
  mov R1, 260
  mov [SP+1], R1
  mov R1, __literal_string_5237
  mov [SP+2], R1
  call __function_print_at
  mov R1, 515
  mov [SP], R1
  mov R1, 280
  mov [SP+1], R1
  mov R1, __literal_string_5241
  mov [SP+2], R1
  call __function_print_at
  mov R1, 515
  mov [SP], R1
  mov R1, 300
  mov [SP+1], R1
  mov R1, __literal_string_5245
  mov [SP+2], R1
  call __function_print_at
__if_5222_end:
__if_5198_end:
__if_5174_end:
__if_5150_end:
__if_5126_end:
__if_5102_end:
__if_5032_end:
  mov R1, [BP-31]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  lea R2, [BP-30]
  mov [SP], R2
  call __function_strlen
  mov R1, R0
  iadd R1, 7
  imul R1, 10
  isgn R1
  iadd R1, 640
  mov [BP-50], R1
  mov R1, [BP-50]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, __literal_string_5262
  mov [SP+2], R1
  call __function_print_at
  lea R2, [BP-30]
  mov [SP], R2
  call __function_strlen
  mov R1, R0
  imul R1, 10
  isgn R1
  iadd R1, 640
  mov [BP-50], R1
  mov R1, [BP-50]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-34]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  lea R2, [BP-30]
  mov [SP], R2
  call __function_strlen
  mov R1, R0
  iadd R1, 5
  imul R1, 10
  isgn R1
  iadd R1, 640
  mov [BP-50], R1
  mov R1, [BP-50]
  mov [SP], R1
  mov R1, 20
  mov [SP+1], R1
  mov R1, __literal_string_5289
  mov [SP+2], R1
  call __function_print_at
  lea R2, [BP-30]
  mov [SP], R2
  call __function_strlen
  mov R1, R0
  imul R1, 10
  isgn R1
  iadd R1, 640
  mov [BP-50], R1
  mov R1, [BP-50]
  mov [SP], R1
  mov R1, 20
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_print_at
  call __function_end_frame
  jmp __while_3155_start
__while_3155_end:
  mov R0, 0
  mov [BP-47], R0
__while_5304_start:
__while_5304_continue:
  mov R0, [BP-33]
  igt R0, 0
  jf R0, __while_5304_end
  mov R0, [BP-33]
  idiv R0, 2
  mov [BP-33], R0
  mov R0, [BP-47]
  mov R1, R0
  iadd R1, 1
  mov [BP-47], R1
  jmp __while_5304_start
__while_5304_end:
  mov R0, [BP-47]
  isub R0, 5
  mov [BP-47], R0
__while_5317_start:
__while_5317_continue:
  call __function_gamepad_button_b
  mov R1, R0
  ile R1, 0
  mov R0, R1
  jf R0, __while_5317_end
  mov R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R1, 0
  mov [SP], R1
  mov R1, 110
  mov [SP+1], R1
  mov R1, __literal_string_5331
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 130
  mov [SP+1], R1
  mov R1, __literal_string_5335
  mov [SP+2], R1
  call __function_print_at
  mov R1, 230
  mov [SP], R1
  mov R1, 130
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_print_at
  lea R2, [BP-30]
  mov [SP], R2
  call __function_strlen
  mov R1, R0
  imul R1, 10
  iadd R1, 230
  mov [BP-50], R1
  mov R1, [BP-50]
  mov [SP], R1
  mov R1, 130
  mov [SP+1], R1
  mov R1, __literal_string_5350
  mov [SP+2], R1
  call __function_print_at
  mov R1, 0
  mov [SP], R1
  mov R1, 150
  mov [SP+1], R1
  mov R1, __literal_string_5354
  mov [SP+2], R1
  call __function_print_at
__if_5355_start:
  call __function_get_frame_counter
  mov R1, R0
  imod R1, 60
  ilt R1, 30
  mov R0, R1
  jf R0, __if_5355_else
  mov R1, 0
  mov [SP], R1
  mov R1, 290
  mov [SP+1], R1
  mov R1, __literal_string_5365
  mov [SP+2], R1
  call __function_print_at
  jmp __if_5355_end
__if_5355_else:
__if_5366_start:
  call __function_get_frame_counter
  mov R1, R0
  imod R1, 60
  igt R1, 30
  mov R0, R1
  jf R0, __if_5366_end
  mov R1, 0
  mov [SP], R1
  mov R1, 290
  mov [SP+1], R1
  mov R1, __literal_string_5376
  mov [SP+2], R1
  call __function_print_at
__if_5366_end:
__if_5355_end:
  call __function_end_frame
  jmp __while_5317_start
__while_5317_end:
  jmp __while_3113_start
__while_3113_end:
__function_main_return:
  mov SP, BP
  pop BP
  ret

__literal_string_1796:
  string "0123456789ABCDEF"
__literal_string_1906:
  string "."
__literal_string_1917:
  string "0"
__literal_string_3030:
  string " > Oh no, your device is being attacked!"
__literal_string_3034:
  string " > Random bits are invading to steal your data"
__literal_string_3038:
  string " > The only way to destroy them is with Bitwise Logic (TM)"
__literal_string_3042:
  string " > You only have a few towers at your disposal:"
__literal_string_3046:
  string " > AND, OR, NOT, XOR, LSHIFT, and RSHIFT"
__literal_string_3050:
  string " > Use these towers to destroy the rogue numbers"
__literal_string_3054:
  string " > I will give you 255 bits to buy your first tower(s)"
__literal_string_3058:
  string " > Good luck"
__literal_string_3062:
  string " > Use the D-Pad to move your cursor"
__literal_string_3066:
  string " > Use B to interact"
__literal_string_3070:
  string " > Use A to upgrade"
__literal_string_3074:
  string " > Press B to start"
__literal_string_3085:
  string " > _"
__literal_string_3096:
  string " > "
__literal_string_5117:
  string "Left Shift"
__literal_string_5121:
  string "Cost:50 bits"
__literal_string_5125:
  string "Causes overflows"
__literal_string_5141:
  string "Right Shift"
__literal_string_5145:
  string "Cost:30 bits"
__literal_string_5149:
  string "Causes underflows"
__literal_string_5165:
  string "And"
__literal_string_5169:
  string "Cost:75 bits"
__literal_string_5173:
  string "Does Bitwise And"
__literal_string_5189:
  string "Or"
__literal_string_5193:
  string "Cost:150 bits"
__literal_string_5197:
  string "Does Bitwise Or"
__literal_string_5213:
  string "Xor"
__literal_string_5217:
  string "Cost:125 bits"
__literal_string_5221:
  string "Does Bitwise Xor"
__literal_string_5237:
  string "Not"
__literal_string_5241:
  string "Cost:50 bits"
__literal_string_5245:
  string "Inverts Bits"
__literal_string_5262:
  string "Health:"
__literal_string_5289:
  string "Bits:"
__literal_string_5331:
  string " > You\'re device has been comprimised"
__literal_string_5335:
  string " > You made it through"
__literal_string_5350:
  string " waves"
__literal_string_5354:
  string " > Try again?"
__literal_string_5365:
  string " > _"
__literal_string_5376:
  string " > "
