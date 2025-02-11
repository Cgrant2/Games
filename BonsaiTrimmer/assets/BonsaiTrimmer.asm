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

__function_draw_pixel:
  push BP
  mov BP, SP
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegion
__function_draw_pixel_return:
  mov SP, BP
  pop BP
  ret

__function_draw_horizontal_line:
  push BP
  mov BP, SP
  isub SP, 2
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
  mov R1, [BP+4]
  mov R2, [BP+2]
  isub R1, R2
  iadd R1, 1
  cif R1
  mov [SP], R1
  mov R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__function_draw_horizontal_line_return:
  mov SP, BP
  pop BP
  ret

__function_draw_vertical_line:
  push BP
  mov BP, SP
  isub SP, 2
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
  mov R1, 1
  cif R1
  mov [SP], R1
  mov R1, [BP+4]
  mov R2, [BP+3]
  isub R1, R2
  iadd R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__function_draw_vertical_line_return:
  mov SP, BP
  pop BP
  ret

__function_draw_line:
  push BP
  mov BP, SP
  isub SP, 6
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
__if_1982_start:
  mov R0, [BP+2]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_1987
  mov R1, [BP+3]
  mov R2, [BP+5]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1987:
  jf R0, __if_1982_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_at
  jmp __function_draw_line_return
__if_1982_end:
  mov R0, [BP+4]
  mov R1, [BP+2]
  isub R0, R1
  mov [BP-1], R0
  mov R0, [BP+5]
  mov R1, [BP+3]
  isub R0, R1
  mov [BP-2], R0
  mov R2, [BP-1]
  mov R3, [BP-1]
  imul R2, R3
  mov R3, [BP-2]
  mov R4, [BP-2]
  imul R3, R4
  iadd R2, R3
  cif R2
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  fadd R1, 1.000000
  mov R0, R1
  mov [BP-3], R0
  mov R1, [BP-2]
  cif R1
  mov [SP], R1
  mov R1, [BP-1]
  cif R1
  mov [SP+1], R1
  call __function_atan2
  mov [BP-4], R0
  mov R1, [BP-4]
  mov [SP], R1
  call __function_set_drawing_angle
  mov R1, [BP-3]
  mov [SP], R1
  mov R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_rotozoomed_at
__function_draw_line_return:
  mov SP, BP
  pop BP
  ret

__function_draw_rectangle:
  push BP
  mov BP, SP
  isub SP, 2
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
  mov R1, [BP+4]
  mov R2, [BP+2]
  isub R1, R2
  iadd R1, 1
  cif R1
  mov [SP], R1
  mov R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, 1
  cif R1
  mov [SP], R1
  mov R1, [BP+5]
  mov R2, [BP+3]
  isub R1, R2
  iadd R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__function_draw_rectangle_return:
  mov SP, BP
  pop BP
  ret

__function_draw_filled_rectangle:
  push BP
  mov BP, SP
  isub SP, 2
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
  mov R1, [BP+4]
  mov R2, [BP+2]
  isub R1, R2
  iadd R1, 1
  cif R1
  mov [SP], R1
  mov R1, [BP+5]
  mov R2, [BP+3]
  isub R1, R2
  iadd R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__function_draw_filled_rectangle_return:
  mov SP, BP
  pop BP
  ret

__function_draw_circle:
  push BP
  mov BP, SP
  isub SP, 15
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
  mov R2, [BP+4]
  cif R2
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  fmul R1, 4.000000
  mov R0, R1
  cfi R0
  mov [BP-1], R0
  mov R2, 2
  mov [SP], R2
  mov R2, [BP-1]
  mov [SP+1], R2
  call __function_max
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, 6.283185
  mov R1, [BP-1]
  cif R1
  fdiv R0, R1
  mov [BP-2], R0
  mov R0, [BP+4]
  cif R0
  mov R1, [BP-2]
  fmul R0, R1
  mov [BP-3], R0
  mov R2, [BP-3]
  mov [SP], R2
  call __function_ceil
  mov R1, R0
  mov [BP-13], R1
  mov R1, [BP-13]
  mov [SP], R1
  mov R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R0, [BP+2]
  mov R1, [BP+4]
  iadd R0, R1
  mov [BP-4], R0
  mov R0, [BP+3]
  mov [BP-5], R0
  mov R0, 1
  mov [BP-6], R0
__for_2123_start:
  mov R0, [BP-6]
  mov R1, [BP-1]
  ile R0, R1
  jf R0, __for_2123_end
  mov R0, [BP-2]
  mov R1, [BP-6]
  cif R1
  fmul R0, R1
  mov [BP-7], R0
  mov R1, [BP+2]
  cif R1
  mov R2, [BP+4]
  cif R2
  mov R4, [BP-7]
  mov [SP], R4
  call __function_cos
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-13], R1
  mov R1, [BP-13]
  mov [SP], R1
  call __function_round
  cfi R0
  mov [BP-8], R0
  mov R1, [BP+3]
  cif R1
  mov R2, [BP+4]
  cif R2
  mov R4, [BP-7]
  mov [SP], R4
  call __function_sin
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-13], R1
  mov R1, [BP-13]
  mov [SP], R1
  call __function_round
  cfi R0
  mov [BP-9], R0
__if_2156_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_2161
  mov R1, [BP-5]
  mov R2, [BP-9]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2161:
  jf R0, __if_2156_else
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_draw_region_at
  jmp __if_2156_end
__if_2156_else:
  mov R0, [BP-8]
  mov R1, [BP-4]
  isub R0, R1
  mov [BP-10], R0
  mov R0, [BP-9]
  mov R1, [BP-5]
  isub R0, R1
  mov [BP-11], R0
  mov R1, [BP-11]
  cif R1
  mov [SP], R1
  mov R1, [BP-10]
  cif R1
  mov [SP+1], R1
  call __function_atan2
  mov [BP-12], R0
  mov R1, [BP-12]
  mov [SP], R1
  call __function_set_drawing_angle
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_draw_region_rotozoomed_at
__if_2156_end:
  mov R0, [BP-8]
  mov [BP-4], R0
  mov R0, [BP-9]
  mov [BP-5], R0
__for_2123_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_2123_start
__for_2123_end:
__function_draw_circle_return:
  mov SP, BP
  pop BP
  ret

__function_draw_filled_circle:
  push BP
  mov BP, SP
  isub SP, 10
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
  mov R0, [BP+3]
  mov R1, [BP+4]
  isub R0, R1
  mov [BP-1], R0
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R0, R1
  mov [BP-2], R0
__if_2209_start:
  mov R0, [BP-2]
  ilt R0, 0
  jt R0, __LogicalOr_ShortCircuit_2214
  mov R1, [BP-1]
  ige R1, 360
  or R0, R1
__LogicalOr_ShortCircuit_2214:
  jf R0, __if_2209_end
  jmp __function_draw_filled_circle_return
__if_2209_end:
  mov R2, [BP-1]
  mov [SP], R2
  mov R2, 0
  mov [SP+1], R2
  call __function_max
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R2, [BP-2]
  mov [SP], R2
  mov R2, 359
  mov [SP+1], R2
  call __function_min
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
  mov R0, [BP+4]
  cif R0
  fadd R0, 0.300000
  mov R1, [BP+4]
  cif R1
  fadd R1, 0.300000
  fmul R0, R1
  mov [BP-3], R0
  mov R0, [BP-1]
  mov [BP-4], R0
__for_2241_start:
  mov R0, [BP-4]
  mov R1, [BP-2]
  ile R0, R1
  jf R0, __for_2241_end
  mov R0, [BP-4]
  mov R1, [BP+3]
  isub R0, R1
  mov [BP-5], R0
  mov R2, [BP-3]
  mov R3, [BP-5]
  mov R4, [BP-5]
  imul R3, R4
  cif R3
  fsub R2, R3
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  mov [BP-7], R1
  mov R1, [BP-7]
  mov [SP], R1
  call __function_round
  cfi R0
  mov [BP-6], R0
  mov R1, [BP+2]
  mov R2, [BP-6]
  isub R1, R2
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+2]
  mov R2, [BP-6]
  iadd R1, R2
  mov [SP+2], R1
  call __function_draw_horizontal_line
__for_2241_continue:
  mov R0, [BP-4]
  mov R1, R0
  iadd R1, 1
  mov [BP-4], R1
  jmp __for_2241_start
__for_2241_end:
__function_draw_filled_circle_return:
  mov SP, BP
  pop BP
  ret

__function_draw_arc:
  push BP
  mov BP, SP
  isub SP, 15
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
  mov R2, [BP+4]
  cif R2
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  fmul R1, 4.000000
  mov R0, R1
  cfi R0
  mov [BP-1], R0
  mov R0, [BP-1]
  cif R0
  mov R1, [BP+6]
  mov R2, [BP+5]
  fsub R1, R2
  fdiv R1, 6.283185
  fmul R0, R1
  cfi R0
  mov [BP-1], R0
  mov R2, 2
  mov [SP], R2
  mov R2, [BP-1]
  mov [SP+1], R2
  call __function_max
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, [BP+6]
  mov R1, [BP+5]
  fsub R0, R1
  mov R1, [BP-1]
  cif R1
  fdiv R0, R1
  mov [BP-2], R0
  mov R0, [BP+4]
  cif R0
  mov R1, [BP-2]
  fmul R0, R1
  mov [BP-3], R0
  mov R2, [BP-3]
  mov [SP], R2
  call __function_ceil
  mov R1, R0
  mov [BP-13], R1
  mov R1, [BP-13]
  mov [SP], R1
  mov R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  cif R1
  mov R2, [BP+4]
  cif R2
  mov R4, [BP+5]
  mov [SP], R4
  call __function_cos
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-13], R1
  mov R1, [BP-13]
  mov [SP], R1
  call __function_round
  cfi R0
  mov [BP-4], R0
  mov R1, [BP+3]
  cif R1
  mov R2, [BP+4]
  cif R2
  mov R4, [BP+5]
  mov [SP], R4
  call __function_sin
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-13], R1
  mov R1, [BP-13]
  mov [SP], R1
  call __function_round
  cfi R0
  mov [BP-5], R0
  mov R0, 1
  mov [BP-6], R0
__for_2337_start:
  mov R0, [BP-6]
  mov R1, [BP-1]
  ile R0, R1
  jf R0, __for_2337_end
  mov R0, [BP+5]
  mov R1, [BP-2]
  mov R2, [BP-6]
  cif R2
  fmul R1, R2
  fadd R0, R1
  mov [BP-7], R0
  mov R1, [BP+2]
  cif R1
  mov R2, [BP+4]
  cif R2
  mov R4, [BP-7]
  mov [SP], R4
  call __function_cos
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-13], R1
  mov R1, [BP-13]
  mov [SP], R1
  call __function_round
  cfi R0
  mov [BP-8], R0
  mov R1, [BP+3]
  cif R1
  mov R2, [BP+4]
  cif R2
  mov R4, [BP-7]
  mov [SP], R4
  call __function_sin
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-13], R1
  mov R1, [BP-13]
  mov [SP], R1
  call __function_round
  cfi R0
  mov [BP-9], R0
__if_2372_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_2377
  mov R1, [BP-5]
  mov R2, [BP-9]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2377:
  jf R0, __if_2372_else
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_draw_region_at
  jmp __if_2372_end
__if_2372_else:
  mov R0, [BP-8]
  mov R1, [BP-4]
  isub R0, R1
  mov [BP-10], R0
  mov R0, [BP-9]
  mov R1, [BP-5]
  isub R0, R1
  mov [BP-11], R0
  mov R1, [BP-11]
  cif R1
  mov [SP], R1
  mov R1, [BP-10]
  cif R1
  mov [SP+1], R1
  call __function_atan2
  mov [BP-12], R0
  mov R1, [BP-12]
  mov [SP], R1
  call __function_set_drawing_angle
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_draw_region_rotozoomed_at
__if_2372_end:
  mov R0, [BP-8]
  mov [BP-4], R0
  mov R0, [BP-9]
  mov [BP-5], R0
__for_2337_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_2337_start
__for_2337_end:
__function_draw_arc_return:
  mov SP, BP
  pop BP
  ret

__function_mkleaf:
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
  mov R0, -1
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+2]
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0
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
  mov R0, [BP-1]
__function_mkleaf_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rmleaf:
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
__function_rmleaf_return:
  iadd SP, 1
  pop R1
  mov SP, BP
  pop BP
  ret

__function_mktree:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 1
  mov R0, -1
  mov [BP-1], R0
  mov R2, 2
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, [BP+2]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, [BP-1]
__function_mktree_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_treeinsert:
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
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
__if_2517_start:
  mov R0, [BP-1]
  ieq R0, -1
  jf R0, __if_2517_else
  mov R0, [BP+3]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 4
  mov [R1], R0
  jmp __if_2517_end
__if_2517_else:
__while_2531_start:
__while_2531_continue:
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, -1
  jf R0, __while_2531_end
__if_2537_start:
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_2537_else
__if_2544_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_2544_else
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  mov R2, [BP+3]
  iadd R2, 4
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  jmp __if_2544_end
__if_2544_else:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R2, [BP+3]
  iadd R2, 4
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__if_2544_end:
  jmp __if_2537_end
__if_2537_else:
__if_2570_start:
  mov R1, [BP-1]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_2570_else
  mov R0, [BP+3]
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  mov R2, [BP+3]
  iadd R2, 4
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  jmp __if_2570_end
__if_2570_else:
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-1], R0
  mov R2, [BP+3]
  iadd R2, 4
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__if_2570_end:
__if_2537_end:
  jmp __while_2531_start
__while_2531_end:
__if_2517_end:
  mov R0, [BP+2]
__function_treeinsert_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_treeobtain:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  push R3
  isub SP, 1
  mov R0, -1
  mov [BP-1], R0
  mov R2, 7
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, [BP+3]
  mov R0, [R0]
  mov [BP-1], R0
__if_2614_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2614_else
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
__while_2624_start:
__while_2624_continue:
  mov R1, [BP-1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __while_2624_end
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_2624_start
__while_2624_end:
  jmp __if_2614_end
__if_2614_else:
__if_2634_start:
  mov R1, [BP-1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2634_else
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-1], R0
  jmp __if_2634_end
__if_2634_else:
  mov R0, [BP+3]
  mov R0, [R0]
  mov [BP-1], R0
__if_2634_end:
__if_2614_end:
__if_2650_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_2658
  mov R1, [BP-1]
  mov R2, [BP+3]
  mov R2, [R2]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2658:
  jf R0, __if_2650_else
  mov R0, -1
  mov R1, [BP+2]
  mov [R1], R0
  jmp __if_2650_end
__if_2650_else:
__if_2668_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_2676
  mov R1, [BP-1]
  mov R3, [BP+3]
  mov R3, [R3]
  mov R2, [R3]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2676:
  jf R0, __if_2668_else
  mov R0, -1
  mov R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 4
  mov [R1], R0
  jmp __if_2668_end
__if_2668_else:
__if_2702_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2702_end
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 2
  mov [R1], R0
__if_2702_end:
__if_2714_start:
  mov R0, [BP-1]
  mov R3, [BP-1]
  iadd R3, 2
  mov R2, [R3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2714_else
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov [R1], R0
  jmp __if_2714_end
__if_2714_else:
__if_2727_start:
  mov R0, [BP-1]
  mov R3, [BP-1]
  iadd R3, 2
  mov R2, [R3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2727_end
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 1
  mov [R1], R0
__if_2727_end:
__if_2714_end:
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
__if_2748_start:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2748_end
__if_2756_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R3, [BP+3]
  mov R3, [R3]
  iadd R3, 2
  mov R2, [R3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2756_else
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
  mov R2, [BP+3]
  mov R2, [R2]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2756_end
__if_2756_else:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
  mov R2, [BP+3]
  mov R2, [R2]
  iadd R2, 2
  mov R1, [R2]
  mov [R1], R0
__if_2756_end:
__if_2748_end:
  mov R0, -1
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 2
  mov [R1], R0
__if_2802_start:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2802_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-1]
  mov R2, [BP+3]
  mov R2, [R2]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov [R1], R0
__if_2802_end:
__if_2830_start:
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2830_end
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, [BP-1]
  mov R2, [BP+3]
  mov R2, [R2]
  mov R1, [R2]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__if_2830_end:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-1]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 4
  mov [R1], R0
__if_2871_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2871_end
  mov R0, [BP-1]
  mov R1, [BP+2]
  mov [R1], R0
__if_2871_end:
__if_2668_end:
__if_2650_end:
  mov R0, [BP+2]
__function_treeobtain_return:
  iadd SP, 1
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_cleartree:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 2
  mov R0, -1
  mov [BP-1], R0
  mov R2, 7
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
__while_2896_start:
__while_2896_continue:
  mov R1, [BP+2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __while_2896_end
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-1]
  mov [SP+1], R2
  call __function_treeobtain
  mov R1, R0
  mov [BP+2], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  call __function_rmleaf
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  jmp __while_2896_start
__while_2896_end:
  mov R0, [BP+2]
__function_cleartree_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rmtree:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 1
  mov R2, [BP+2]
  mov [SP], R2
  call __function_cleartree
  mov R1, R0
  mov [BP+2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  mov [BP+2], R0
  mov R0, [BP+2]
__function_rmtree_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_mknode:
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
  mov R0, [BP+2]
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
__function_mknode_return:
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
__if_3010_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_3010_else
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_3010_end
__if_3010_else:
__if_3024_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_3024_else
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
  jmp __if_3024_end
__if_3024_else:
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
__if_3024_end:
__if_3010_end:
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
__if_3070_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_3070_else
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_3070_end
__if_3070_else:
__if_3084_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_3084_else
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
  jmp __if_3084_end
__if_3084_else:
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
__if_3084_end:
__if_3070_end:
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
__if_3129_start:
  mov R0, [BP+3]
  mov R0, [R0]
  ine R0, -1
  jf R0, __if_3129_end
__if_3136_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_3136_end
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  mov R1, [BP+2]
  mov [R1], R0
__if_3151_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_3151_else
  mov R0, -1
  mov R2, [BP+2]
  mov R1, [R2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_3151_end
__if_3151_else:
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_3151_end:
__if_3136_end:
__if_3167_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_3167_end
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
__if_3167_end:
__if_3187_start:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_3187_end
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R2, [R2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_3187_end:
__if_3205_start:
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_3205_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R2, [R2]
  mov R1, [R2]
  iadd R1, 1
  mov [R1], R0
__if_3205_end:
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
__if_3129_end:
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
__while_3254_start:
__while_3254_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_3254_end
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
__if_3271_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __if_3271_end
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  lea R0, [BP-1]
  mov [BP-3], R0
__if_3271_end:
  jmp __while_3254_start
__while_3254_end:
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

__function_mkstack:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 1
  mov R0, -1
  mov [BP-1], R0
  mov R2, 6
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  call __function_mklist
  mov R1, R0
  mov R2, [BP-1]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, [BP+2]
  mov R1, [BP-1]
  iadd R1, 4
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
  mov R0, [BP-1]
__function_mkstack_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rmstack:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  isub SP, 1
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  call __function_clearlist
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  call __function_rmlist
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  mov [BP+2], R0
  mov R0, [BP+2]
__function_rmstack_return:
  iadd SP, 1
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_pop:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 2
__if_3374_start:
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, 0
  jf R0, __if_3374_end
__if_3374_end:
__if_3382_start:
  mov R0, [BP+3]
  mov R0, [R0]
  ine R0, -1
  jf R0, __if_3382_end
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_obtain
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  mov [R1], R0
__if_3382_end:
  mov R2, [BP+2]
  iadd R2, 5
  mov R0, [R2]
  mov R1, R0
  isub R1, 1
  mov [R2], R1
  mov R0, [BP+2]
__function_pop_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_push:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  push R4
  isub SP, 3
__if_3407_start:
  mov R0, [BP+3]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_3414
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 4
  mov R2, [R3]
  ilt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3414:
  jf R0, __if_3407_end
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  mov R4, [BP+2]
  iadd R4, 1
  mov R3, [R4]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  mov R2, [BP+3]
  mov [SP+2], R2
  call __function_append
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  mov [R1], R0
__if_3407_end:
  mov R2, [BP+2]
  iadd R2, 5
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP+2]
__function_push_return:
  iadd SP, 3
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_mkstacklist:
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
__function_mkstacklist_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_stackinsert:
  push BP
  mov BP, SP
  push R1
  push R2
__if_3475_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_3475_else
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_3475_end
__if_3475_else:
__if_3489_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_3489_else
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+3]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  jmp __if_3489_end
__if_3489_else:
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+4]
  mov R2, [BP+3]
  iadd R2, 3
  mov R1, [R2]
  iadd R1, 2
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
__if_3489_end:
__if_3475_end:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP+2]
__function_stackinsert_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_stackappend:
  push BP
  mov BP, SP
  push R1
  push R2
__if_3535_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_3535_else
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_3535_end
__if_3535_else:
__if_3549_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_3549_else
  mov R0, [BP+4]
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_3549_end
__if_3549_else:
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+4]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 3
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
__if_3549_end:
__if_3535_end:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, [BP+2]
__function_stackappend_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_stackobtain:
  push BP
  mov BP, SP
  push R1
  push R2
__if_3594_start:
  mov R0, [BP+3]
  mov R0, [R0]
  ine R0, -1
  jf R0, __if_3594_end
__if_3601_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_3601_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+2]
  mov [R1], R0
__if_3616_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_3616_else
  mov R0, -1
  mov R2, [BP+2]
  mov R1, [R2]
  iadd R1, 3
  mov [R1], R0
  jmp __if_3616_end
__if_3616_else:
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_3616_end:
__if_3601_end:
__if_3632_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_3632_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 2
  mov [R1], R0
__if_3632_end:
__if_3652_start:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_3652_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+3]
  mov R2, [R2]
  iadd R2, 3
  mov R1, [R2]
  iadd R1, 2
  mov [R1], R0
__if_3652_end:
__if_3670_start:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_3670_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP+3]
  mov R2, [R2]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 3
  mov [R1], R0
__if_3670_end:
  mov R0, -1
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 3
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  isub R1, 1
  mov [R2], R1
__if_3594_end:
  mov R0, [BP+2]
__function_stackobtain_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_clearstacklist:
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
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
  lea R0, [BP-1]
  mov [BP-3], R0
__while_3719_start:
__while_3719_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_3719_end
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-3]
  mov [SP+1], R2
  call __function_stackobtain
  mov R1, R0
  mov [BP+2], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  call __function_rmstack
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, [BP-2]
  mov [BP-1], R0
__if_3736_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __if_3736_end
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
  lea R0, [BP-1]
  mov [BP-3], R0
__if_3736_end:
  jmp __while_3719_start
__while_3719_end:
  mov R0, [BP+2]
__function_clearstacklist_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rmstacklist:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 1
  mov R2, [BP+2]
  mov [SP], R2
  call __function_clearstacklist
  mov R1, R0
  mov [BP+2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  mov [BP+2], R0
  mov R0, [BP+2]
__function_rmstacklist_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_PrintInOrder:
  push BP
  mov BP, SP
  isub SP, 14
__if_3768_start:
  mov R0, [BP+3]
  ieq R0, -1
  jf R0, __if_3768_end
  jmp __function_PrintInOrder_return
__if_3768_end:
  mov R0, -16711936
  mov [BP-11], R0
__if_3780_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  ine R0, R1
  jf R0, __if_3780_end
  mov R0, 360
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  idiv R0, R1
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
__if_3780_end:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  imul R0, 30
  iadd R0, 25
  mov R1, [BP+3]
  iadd R1, 6
  mov [R1], R0
__if_3803_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_3803_else
  mov R0, -14663552
  mov [BP-11], R0
  mov R0, 320
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  jmp __if_3803_end
__if_3803_else:
__if_3816_start:
  mov R0, [BP+3]
  mov R3, [BP+3]
  iadd R3, 2
  mov R2, [R3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_3816_else
  mov R0, [BP+4]
  mov R1, 100
  mov R3, [BP+3]
  iadd R3, 4
  mov R2, [R3]
  idiv R1, R2
  iadd R0, R1
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  jmp __if_3816_end
__if_3816_else:
  mov R0, [BP+4]
  mov R1, 100
  mov R3, [BP+3]
  iadd R3, 4
  mov R2, [R3]
  idiv R1, R2
  isub R0, R1
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
__if_3816_end:
__if_3803_end:
  mov R1, [BP-11]
  mov [SP], R1
  call __function_set_multiply_color
  mov R2, [BP+3]
  iadd R2, 3
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R2, [BP+3]
  iadd R2, 5
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_print_at
  mov R2, [BP+3]
  iadd R2, 5
  mov R1, [R2]
  iadd R1, 5
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 6
  mov R1, [R2]
  iadd R1, 10
  mov [SP+1], R1
  mov R1, 12
  mov [SP+2], R1
  call __function_draw_circle
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP+3]
  iadd R2, 5
  mov R1, [R2]
  mov [SP+2], R1
  call __function_PrintInOrder
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP+3]
  iadd R2, 5
  mov R1, [R2]
  mov [SP+2], R1
  call __function_PrintInOrder
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
__function_PrintInOrder_return:
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 29
  call __function_get_time
  mov R1, R0
  mov [BP-26], R1
  mov R1, [BP-26]
  mov [SP], R1
  call __function_srand
  call __function_rand
  mov R1, R0
  imod R1, 9
  mov R0, R1
  mov [BP-2], R0
  mov R0, 5
  mov [BP-15], R0
  mov R0, 5
  mov [BP-16], R0
  mov R0, 0
  mov [BP-17], R0
  mov R0, 0
  mov [BP-18], R0
  mov R0, 0
  mov [BP-19], R0
  mov R1, 6
  mov [SP], R1
  call __function_mktree
  mov [BP-20], R0
  mov R0, -1
  mov [BP-21], R0
  mov R2, 7
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-21], R1
  mov R0, R1
  mov R0, -1
  mov [BP-22], R0
  mov R2, 7
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-22], R1
  mov R0, R1
  mov R0, -1
  mov [BP-23], R0
  mov R2, 7
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-23], R1
  mov R0, R1
  mov R1, 10
  mov [SP], R1
  call __function_mkstack
  mov [BP-24], R0
  mov R0, -1
  mov [BP-25], R0
  mov R2, 3
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov [BP-25], R1
  mov R0, R1
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
  mov R1, 0.750000
  mov [SP], R1
  call __function_set_channel_volume
__while_3964_start:
__while_3964_continue:
  mov R0, 1
  jf R0, __while_3964_end
  mov R0, 5
  mov [BP-15], R0
  mov R0, 5
  mov [BP-16], R0
  mov R0, 0
  mov [BP-17], R0
  mov R0, 0
  mov [BP-18], R0
  mov R0, 0
  mov [BP-19], R0
__while_3982_start:
__while_3982_continue:
  call __function_gamepad_button_b
  mov R1, R0
  ine R1, 2
  mov R0, R1
  jf R0, __while_3982_end
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R1, -16711936
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, 200
  mov [SP], R1
  mov R1, 20
  mov [SP+1], R1
  mov R1, __literal_string_3994
  mov [SP+2], R1
  call __function_print_at
  mov R1, 110
  mov [SP], R1
  mov R1, 40
  mov [SP+1], R1
  mov R1, __literal_string_3998
  mov [SP+2], R1
  call __function_print_at
  mov R1, 145
  mov [SP], R1
  mov R1, 60
  mov [SP+1], R1
  mov R1, __literal_string_4002
  mov [SP+2], R1
  call __function_print_at
  mov R1, -14663552
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, 295
  mov [SP], R1
  mov R1, 80
  mov [SP+1], R1
  mov R1, __literal_string_4008
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 100
  mov [SP+1], R1
  mov R1, __literal_string_4012
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 120
  mov [SP+1], R1
  mov R1, __literal_string_4016
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 140
  mov [SP+1], R1
  mov R1, __literal_string_4020
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 160
  mov [SP+1], R1
  mov R1, __literal_string_4024
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 180
  mov [SP+1], R1
  mov R1, __literal_string_4028
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 200
  mov [SP+1], R1
  mov R1, __literal_string_4032
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 220
  mov [SP+1], R1
  mov R1, __literal_string_4036
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 240
  mov [SP+1], R1
  mov R1, __literal_string_4040
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 260
  mov [SP+1], R1
  mov R1, __literal_string_4044
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 280
  mov [SP+1], R1
  mov R1, __literal_string_4048
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 300
  mov [SP+1], R1
  mov R1, __literal_string_4052
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 320
  mov [SP+1], R1
  mov R1, __literal_string_4056
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 340
  mov [SP+1], R1
  mov R1, __literal_string_4060
  mov [SP+2], R1
  call __function_print_at
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  call __function_end_frame
  jmp __while_3982_start
__while_3982_end:
__while_4064_start:
__while_4064_continue:
  mov R0, [BP-15]
  igt R0, 0
  jf R0, __while_4064_end
  mov R0, 0
  mov [BP-1], R0
__for_4069_start:
  mov R0, [BP-1]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_4069_end
  call __function_rand
  mov R1, R0
  imod R1, 900000000
  iadd R1, 100000000
  mov [BP-3], R1
  mov R0, R1
__for_4069_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_4069_start
__for_4069_end:
  mov R0, [BP-3]
  mov [BP-4], R0
__while_4091_start:
__while_4091_continue:
  mov R0, [BP-3]
  igt R0, 0
  jf R0, __while_4091_end
  mov R0, [BP-3]
  imod R0, 10
  mov [BP-1], R0
  mov R0, [BP-3]
  mov R1, [BP-1]
  isub R0, R1
  idiv R0, 10
  mov [BP-3], R0
  mov R2, [BP-1]
  mov [SP], R2
  call __function_mknode
  mov R1, R0
  mov [BP-25], R1
  mov R0, R1
  mov R2, [BP-24]
  mov [SP], R2
  mov R2, [BP-25]
  mov [SP+1], R2
  call __function_push
  mov R1, R0
  mov [BP-24], R1
  mov R0, R1
  jmp __while_4091_start
__while_4091_end:
__while_4118_start:
__while_4118_continue:
  mov R1, [BP-24]
  iadd R1, 5
  mov R0, [R1]
  igt R0, 0
  jf R0, __while_4118_end
  mov R1, [BP-24]
  mov R0, [R1]
  mov [BP-25], R0
  mov R2, [BP-24]
  mov [SP], R2
  lea R2, [BP-25]
  mov [SP+1], R2
  call __function_pop
  mov R1, R0
  mov [BP-24], R1
  mov R0, R1
  mov R3, [BP-25]
  iadd R3, 2
  mov R2, [R3]
  mov [SP], R2
  call __function_mkleaf
  mov R1, R0
  mov [BP-21], R1
  mov R0, R1
  mov R2, [BP-20]
  mov [SP], R2
  mov R2, [BP-21]
  mov [SP+1], R2
  call __function_treeinsert
  mov R1, R0
  mov [BP-20], R1
  mov R0, R1
__if_4144_start:
  call __function_rand
  mov R1, R0
  imod R1, 4
  ieq R1, 0
  jf R1, __LogicalAnd_ShortCircuit_4152
  mov R2, [BP-18]
  bnot R2
  and R1, R2
__LogicalAnd_ShortCircuit_4152:
  jf R1, __LogicalAnd_ShortCircuit_4154
  mov R2, [BP-21]
  mov R4, [BP-20]
  mov R3, [R4]
  ine R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_4154:
  mov R0, R1
  jf R0, __if_4144_else
  mov R0, [BP-21]
  mov [BP-23], R0
  mov R0, 1
  mov [BP-18], R0
  jmp __if_4144_end
__if_4144_else:
__if_4165_start:
  mov R0, [BP-18]
  bnot R0
  jf R0, __LogicalAnd_ShortCircuit_4168
  mov R2, [BP-24]
  iadd R2, 5
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_4168:
  jf R0, __if_4165_end
  mov R0, [BP-21]
  mov [BP-23], R0
  mov R0, 1
  mov [BP-18], R0
__if_4165_end:
__if_4144_end:
  jmp __while_4118_start
__while_4118_end:
  mov R1, [BP-20]
  mov R0, [R1]
  mov [BP-21], R0
__while_4184_start:
__while_4184_continue:
  mov R0, [BP-19]
  ine R0, 1
  jf R0, __LogicalAnd_ShortCircuit_4189
  mov R1, [BP-17]
  mov R2, [BP-16]
  ile R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_4189:
  jf R0, __LogicalAnd_ShortCircuit_4193
  mov R1, [BP-15]
  ige R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_4193:
  jf R0, __while_4184_end
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
__if_4199_start:
  mov R1, [BP-20]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4199_end
__if_4205_start:
  call __function_gamepad_left
  mov R1, R0
  ieq R1, 1
  jf R1, __LogicalAnd_ShortCircuit_4211
  mov R3, [BP-21]
  iadd R3, 1
  mov R2, [R3]
  ine R2, -1
  and R1, R2
__LogicalAnd_ShortCircuit_4211:
  mov R0, R1
  jf R0, __if_4205_end
  mov R1, [BP-21]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-21], R0
__if_4205_end:
__if_4219_start:
  call __function_gamepad_right
  mov R1, R0
  ieq R1, 1
  jf R1, __LogicalAnd_ShortCircuit_4225
  mov R3, [BP-21]
  mov R2, [R3]
  ine R2, -1
  and R1, R2
__LogicalAnd_ShortCircuit_4225:
  mov R0, R1
  jf R0, __if_4219_end
  mov R1, [BP-21]
  mov R0, [R1]
  mov [BP-21], R0
__if_4219_end:
__if_4233_start:
  call __function_gamepad_up
  mov R1, R0
  ieq R1, 1
  jf R1, __LogicalAnd_ShortCircuit_4239
  mov R3, [BP-21]
  iadd R3, 2
  mov R2, [R3]
  ine R2, -1
  and R1, R2
__LogicalAnd_ShortCircuit_4239:
  mov R0, R1
  jf R0, __if_4233_end
  mov R1, [BP-21]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-21], R0
__if_4233_end:
__if_4247_start:
  call __function_gamepad_left
  mov R1, R0
  igt R1, 30
  jf R1, __LogicalAnd_ShortCircuit_4253
  mov R3, [BP-21]
  iadd R3, 1
  mov R2, [R3]
  ine R2, -1
  and R1, R2
__LogicalAnd_ShortCircuit_4253:
  mov R0, R1
  jf R0, __if_4247_end
  mov R1, [BP-21]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-21], R0
__if_4247_end:
__if_4261_start:
  call __function_gamepad_right
  mov R1, R0
  igt R1, 30
  jf R1, __LogicalAnd_ShortCircuit_4267
  mov R3, [BP-21]
  mov R2, [R3]
  ine R2, -1
  and R1, R2
__LogicalAnd_ShortCircuit_4267:
  mov R0, R1
  jf R0, __if_4261_end
  mov R1, [BP-21]
  mov R0, [R1]
  mov [BP-21], R0
__if_4261_end:
__if_4275_start:
  call __function_gamepad_up
  mov R1, R0
  igt R1, 30
  jf R1, __LogicalAnd_ShortCircuit_4281
  mov R3, [BP-21]
  iadd R3, 2
  mov R2, [R3]
  ine R2, -1
  and R1, R2
__LogicalAnd_ShortCircuit_4281:
  mov R0, R1
  jf R0, __if_4275_end
  mov R1, [BP-21]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-21], R0
__if_4275_end:
__if_4289_start:
  call __function_gamepad_button_b
  mov R1, R0
  ieq R1, 1
  mov R0, R1
  jf R0, __if_4289_end
  mov R1, 1
  mov [SP], R1
  call __function_select_sound
  mov R1, 1
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  call __function_play_sound_in_channel
  mov R1, 2
  mov [SP], R1
  call __function_select_channel
  mov R0, [BP-17]
  mov R1, R0
  iadd R1, 1
  mov [BP-17], R1
  mov R0, [BP-15]
  mov R1, R0
  isub R1, 1
  mov [BP-15], R1
__if_4305_start:
  mov R1, [BP-21]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP-23]
  iadd R2, 3
  mov R1, [R2]
  ile R0, R1
  jf R0, __LogicalAnd_ShortCircuit_4312
  mov R1, [BP-21]
  mov R2, [BP-23]
  ine R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_4312:
  jf R0, __if_4305_else
__while_4316_start:
__while_4316_continue:
  mov R1, [BP-21]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __while_4316_end
  mov R1, [BP-21]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-22], R0
  mov R2, [BP-20]
  mov [SP], R2
  lea R2, [BP-22]
  mov [SP+1], R2
  call __function_treeobtain
  mov R1, R0
  mov [BP-20], R1
  mov R0, R1
  mov R2, [BP-22]
  mov [SP], R2
  call __function_rmleaf
  mov R1, R0
  mov [BP-22], R1
  mov R0, R1
  jmp __while_4316_start
__while_4316_end:
  jmp __if_4305_end
__if_4305_else:
__if_4336_start:
  mov R1, [BP-21]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP-23]
  iadd R2, 3
  mov R1, [R2]
  igt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_4343
  mov R1, [BP-21]
  mov R2, [BP-23]
  ine R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_4343:
  jf R0, __if_4336_else
__while_4347_start:
__while_4347_continue:
  mov R1, [BP-21]
  mov R0, [R1]
  ine R0, -1
  jf R0, __while_4347_end
  mov R1, [BP-21]
  mov R0, [R1]
  mov [BP-22], R0
  mov R2, [BP-20]
  mov [SP], R2
  lea R2, [BP-22]
  mov [SP+1], R2
  call __function_treeobtain
  mov R1, R0
  mov [BP-20], R1
  mov R0, R1
  mov R2, [BP-22]
  mov [SP], R2
  call __function_rmleaf
  mov R1, R0
  mov [BP-22], R1
  mov R0, R1
  jmp __while_4347_start
__while_4347_end:
  jmp __if_4336_end
__if_4336_else:
__if_4367_start:
  mov R1, [BP-21]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP-23]
  iadd R2, 3
  mov R1, [R2]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_4374
  mov R1, [BP-21]
  mov R3, [BP-20]
  mov R2, [R3]
  ine R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_4374:
  jf R0, __if_4367_end
  mov R0, 1
  mov [BP-19], R0
__if_4367_end:
__if_4336_end:
__if_4305_end:
__if_4289_end:
__if_4199_end:
  mov R1, [BP-16]
  mov R2, [BP-17]
  isub R1, R2
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R1, 10
  mov [SP], R1
  mov R1, 10
  mov [SP+1], R1
  mov R1, __literal_string_4391
  mov [SP+2], R1
  call __function_print_at
  mov R1, 140
  mov [SP], R1
  mov R1, 10
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R1, 10
  mov [SP], R1
  mov R1, 30
  mov [SP+1], R1
  mov R1, __literal_string_4403
  mov [SP+2], R1
  call __function_print_at
  mov R1, 80
  mov [SP], R1
  mov R1, 30
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-20]
  mov R0, [R1]
  mov [BP-22], R0
__if_4412_start:
  mov R1, [BP-20]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4412_end
  mov R1, [BP-20]
  mov [SP], R1
  mov R1, [BP-22]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_PrintInOrder
__if_4412_end:
__if_4422_start:
  call __function_get_frame_counter
  mov R1, R0
  imod R1, 60
  ilt R1, 30
  mov R0, R1
  jf R0, __if_4422_else
  mov R1, -16711681
  mov [SP], R1
  call __function_set_multiply_color
  jmp __if_4422_end
__if_4422_else:
  mov R1, -16744193
  mov [SP], R1
  call __function_set_multiply_color
__if_4422_end:
__if_4434_start:
  mov R1, [BP-20]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4434_end
  mov R2, [BP-21]
  iadd R2, 5
  mov R1, [R2]
  iadd R1, 5
  mov [SP], R1
  mov R2, [BP-21]
  iadd R2, 6
  mov R1, [R2]
  iadd R1, 10
  mov [SP+1], R1
  mov R1, 12
  mov [SP+2], R1
  call __function_draw_circle
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
__if_4434_end:
  call __function_end_frame
  jmp __while_4184_start
__while_4184_end:
__if_4453_start:
  mov R0, [BP-19]
  jf R0, __if_4453_end
  mov R0, [BP-15]
  mov R1, [BP-16]
  iadd R0, R1
  mov [BP-15], R0
__if_4453_end:
  mov R2, [BP-20]
  mov [SP], R2
  call __function_cleartree
  mov R1, R0
  mov [BP-20], R1
  mov R0, R1
  mov R0, 0
  mov [BP-18], R0
  mov R0, 0
  mov [BP-19], R0
  mov R0, 0
  mov [BP-17], R0
  jmp __while_4064_start
__while_4064_end:
__while_4472_start:
__while_4472_continue:
  call __function_gamepad_up
  mov R1, R0
  ine R1, 1
  mov R0, R1
  jf R0, __while_4472_end
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R1, -14663552
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, 295
  mov [SP], R1
  mov R1, 40
  mov [SP+1], R1
  mov R1, __literal_string_4484
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 60
  mov [SP+1], R1
  mov R1, __literal_string_4488
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 80
  mov [SP+1], R1
  mov R1, __literal_string_4492
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 100
  mov [SP+1], R1
  mov R1, __literal_string_4496
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 120
  mov [SP+1], R1
  mov R1, __literal_string_4500
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 140
  mov [SP+1], R1
  mov R1, __literal_string_4504
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 160
  mov [SP+1], R1
  mov R1, __literal_string_4508
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 180
  mov [SP+1], R1
  mov R1, __literal_string_4512
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 200
  mov [SP+1], R1
  mov R1, __literal_string_4516
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 220
  mov [SP+1], R1
  mov R1, __literal_string_4520
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 240
  mov [SP+1], R1
  mov R1, __literal_string_4524
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 260
  mov [SP+1], R1
  mov R1, __literal_string_4528
  mov [SP+2], R1
  call __function_print_at
  mov R1, 295
  mov [SP], R1
  mov R1, 280
  mov [SP+1], R1
  mov R1, __literal_string_4532
  mov [SP+2], R1
  call __function_print_at
  mov R1, -16744193
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, 215
  mov [SP], R1
  mov R1, 300
  mov [SP+1], R1
  mov R1, __literal_string_4538
  mov [SP+2], R1
  call __function_print_at
  mov R1, 225
  mov [SP], R1
  mov R1, 320
  mov [SP+1], R1
  mov R1, __literal_string_4542
  mov [SP+2], R1
  call __function_print_at
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  call __function_end_frame
  jmp __while_4472_start
__while_4472_end:
  jmp __while_3964_start
__while_3964_end:
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
__literal_string_3994:
  string "Press B to select a node"
__literal_string_3998:
  string "Press Left and Right to move down a branch"
__literal_string_4002:
  string "Press Up to move to a previous node"
__literal_string_4008:
  string "|||||"
__literal_string_4012:
  string "|||||"
__literal_string_4016:
  string "|||||"
__literal_string_4020:
  string "|||||"
__literal_string_4024:
  string "|||||"
__literal_string_4028:
  string "|||||"
__literal_string_4032:
  string "|||||"
__literal_string_4036:
  string "|||||"
__literal_string_4040:
  string "|||||"
__literal_string_4044:
  string "|||||"
__literal_string_4048:
  string "|||||"
__literal_string_4052:
  string "|||||"
__literal_string_4056:
  string "|||||"
__literal_string_4060:
  string "|||||"
__literal_string_4391:
  string "Guesses Left:"
__literal_string_4403:
  string "Points:"
__literal_string_4484:
  string " | / "
__literal_string_4488:
  string "/||| "
__literal_string_4492:
  string " |||\\"
__literal_string_4496:
  string "|||||"
__literal_string_4500:
  string "|||||"
__literal_string_4504:
  string "|||||"
__literal_string_4508:
  string "|||||"
__literal_string_4512:
  string "|||||"
__literal_string_4516:
  string "|||||"
__literal_string_4520:
  string "|||||"
__literal_string_4524:
  string "|||||"
__literal_string_4528:
  string "|||||"
__literal_string_4532:
  string "|||||"
__literal_string_4538:
  string "Your tree has died =("
__literal_string_4542:
  string "Press Up to restart"
