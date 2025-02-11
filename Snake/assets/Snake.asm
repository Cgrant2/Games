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

__function_mknode:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 1
  mov R0, -1
  mov [BP-1], R0
  mov R2, 4
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
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R1, 3
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
__if_2494_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_2494_else
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2494_end
__if_2494_else:
__if_2508_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2508_else
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
  jmp __if_2508_end
__if_2508_else:
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
__if_2508_end:
__if_2494_end:
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
__if_2554_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_2554_else
  mov R0, [BP+4]
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2554_end
__if_2554_else:
__if_2568_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2568_else
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
  jmp __if_2568_end
__if_2568_else:
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
__if_2568_end:
__if_2554_end:
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
__if_2613_start:
  mov R0, [BP+3]
  mov R0, [R0]
  ine R0, -1
  jf R0, __if_2613_end
__if_2620_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2620_end
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  mov R1, [BP+2]
  mov [R1], R0
__if_2635_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2635_else
  mov R0, -1
  mov R2, [BP+2]
  mov R1, [R2]
  iadd R1, 1
  mov [R1], R0
  jmp __if_2635_end
__if_2635_else:
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_2635_end:
__if_2620_end:
__if_2651_start:
  mov R0, [BP+3]
  mov R0, [R0]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2651_end
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
__if_2651_end:
__if_2671_start:
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2671_end
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R2, [R2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_2671_end:
__if_2689_start:
  mov R1, [BP+3]
  mov R1, [R1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2689_end
  mov R1, [BP+3]
  mov R1, [R1]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R2, [R2]
  mov R1, [R2]
  iadd R1, 1
  mov [R1], R0
__if_2689_end:
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
__if_2613_end:
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
__while_2738_start:
__while_2738_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_2738_end
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
__if_2755_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __if_2755_end
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  lea R0, [BP-1]
  mov [BP-3], R0
__if_2755_end:
  jmp __while_2738_start
__while_2738_end:
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

__function_main:
  push BP
  mov BP, SP
  isub SP, 19
  call __function_get_time
  mov R1, R0
  mov [BP-15], R1
  mov R1, [BP-15]
  mov [SP], R1
  call __function_srand
  call __function_mklist
  mov [BP-13], R0
  mov R1, -1
  mov [SP], R1
  mov R1, -1
  mov [SP+1], R1
  call __function_mknode
  mov [BP-14], R0
__while_2811_start:
__while_2811_continue:
  mov R0, 1
  jf R0, __while_2811_end
  mov R0, 0
  mov [BP-7], R0
  mov R0, 0
  mov [BP-8], R0
  mov R0, 0
  mov [BP-9], R0
  call __function_rand
  mov R1, R0
  imod R1, 42
  imul R1, 15
  isgn R1
  iadd R1, 620
  mov [BP-10], R1
  mov R0, R1
  call __function_rand
  mov R1, R0
  imod R1, 23
  imul R1, 15
  isgn R1
  iadd R1, 345
  mov [BP-11], R1
  mov R0, R1
  mov R0, 20
  mov [BP-12], R0
  mov R0, 0
  mov [BP-1], R0
__for_2846_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_2846_end
  mov R2, [BP-1]
  imul R2, 15
  isgn R2
  iadd R2, 200
  mov [SP], R2
  mov R2, 180
  mov [SP+1], R2
  call __function_mknode
  mov R1, R0
  mov [BP-14], R1
  mov R0, R1
  mov R2, [BP-13]
  mov [SP], R2
  mov R3, [BP-13]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  mov R2, [BP-14]
  mov [SP+2], R2
  call __function_append
  mov R1, R0
  mov [BP-13], R1
  mov R0, R1
__for_2846_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_2846_start
__for_2846_end:
__while_2872_start:
__while_2872_continue:
  call __function_gamepad_button_b
  mov R1, R0
  ine R1, 1
  mov R0, R1
  jf R0, __while_2872_end
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, 225
  mov [SP], R1
  mov R1, 150
  mov [SP+1], R1
  mov R1, __literal_string_2884
  mov [SP+2], R1
  call __function_print_at
  mov R1, 215
  mov [SP], R1
  mov R1, 170
  mov [SP+1], R1
  mov R1, __literal_string_2888
  mov [SP+2], R1
  call __function_print_at
  mov R1, 175
  mov [SP], R1
  mov R1, 190
  mov [SP+1], R1
  mov R1, __literal_string_2892
  mov [SP+2], R1
  call __function_print_at
__if_2893_start:
  call __function_get_frame_counter
  mov R1, R0
  imod R1, 90
  ilt R1, 45
  mov R0, R1
  jf R0, __if_2893_end
  mov R1, 240
  mov [SP], R1
  mov R1, 210
  mov [SP+1], R1
  mov R1, __literal_string_2903
  mov [SP+2], R1
  call __function_print_at
__if_2893_end:
  call __function_end_frame
  jmp __while_2872_start
__while_2872_end:
__while_2905_start:
__while_2905_continue:
  mov R0, [BP-7]
  bnot R0
  jf R0, __while_2905_end
__if_2909_start:
  call __function_gamepad_button_b
  mov R1, R0
  ige R1, 1
  jf R1, __LogicalAnd_ShortCircuit_2914
  mov R2, [BP-12]
  ile R2, 9
  and R1, R2
__LogicalAnd_ShortCircuit_2914:
  mov R0, R1
  jf R0, __if_2909_end
  mov R0, [BP-12]
  isub R0, 3
  mov [BP-12], R0
__if_2909_end:
  mov R0, [BP-12]
  mov R1, R0
  isub R1, 1
  mov [BP-12], R1
__if_2923_start:
  mov R0, [BP-12]
  ilt R0, 0
  jf R0, __if_2923_end
  mov R0, [BP-9]
  mov [BP-8], R0
  mov R1, [BP-13]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-14], R0
__while_2935_start:
__while_2935_continue:
  mov R0, [BP-14]
  mov R2, [BP-13]
  mov R1, [R2]
  ine R0, R1
  jf R0, __while_2935_end
  mov R2, [BP-14]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-14]
  iadd R1, 2
  mov [R1], R0
  mov R2, [BP-14]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-14]
  iadd R1, 3
  mov [R1], R0
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-14], R0
  jmp __while_2935_start
__while_2935_end:
  mov R1, [BP-13]
  mov R0, [R1]
  mov [BP-14], R0
__if_2961_start:
  mov R0, [BP-8]
  ieq R0, 0
  jf R0, __if_2961_else
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  iadd R0, 15
  mov R1, [BP-14]
  iadd R1, 2
  mov [R1], R0
  jmp __if_2961_end
__if_2961_else:
__if_2970_start:
  mov R0, [BP-8]
  ieq R0, 1
  jf R0, __if_2970_else
  mov R1, [BP-14]
  iadd R1, 3
  mov R0, [R1]
  isub R0, 15
  mov R1, [BP-14]
  iadd R1, 3
  mov [R1], R0
  jmp __if_2970_end
__if_2970_else:
__if_2979_start:
  mov R0, [BP-8]
  ieq R0, 2
  jf R0, __if_2979_else
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  isub R0, 15
  mov R1, [BP-14]
  iadd R1, 2
  mov [R1], R0
  jmp __if_2979_end
__if_2979_else:
  mov R1, [BP-14]
  iadd R1, 3
  mov R0, [R1]
  iadd R0, 15
  mov R1, [BP-14]
  iadd R1, 3
  mov [R1], R0
__if_2979_end:
__if_2970_end:
__if_2961_end:
  mov R0, 9
  mov [BP-12], R0
__if_2923_end:
__if_2996_start:
  call __function_gamepad_right
  mov R1, R0
  ieq R1, 1
  jf R1, __LogicalAnd_ShortCircuit_3001
  mov R2, [BP-8]
  ine R2, 2
  and R1, R2
__LogicalAnd_ShortCircuit_3001:
  mov R0, R1
  jf R0, __if_2996_else
  mov R0, 0
  mov [BP-9], R0
  jmp __if_2996_end
__if_2996_else:
__if_3008_start:
  call __function_gamepad_up
  mov R1, R0
  ieq R1, 1
  jf R1, __LogicalAnd_ShortCircuit_3013
  mov R2, [BP-8]
  ine R2, 3
  and R1, R2
__LogicalAnd_ShortCircuit_3013:
  mov R0, R1
  jf R0, __if_3008_else
  mov R0, 1
  mov [BP-9], R0
  jmp __if_3008_end
__if_3008_else:
__if_3020_start:
  call __function_gamepad_left
  mov R1, R0
  ieq R1, 1
  jf R1, __LogicalAnd_ShortCircuit_3025
  mov R2, [BP-8]
  ine R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_3025:
  mov R0, R1
  jf R0, __if_3020_else
  mov R0, 2
  mov [BP-9], R0
  jmp __if_3020_end
__if_3020_else:
__if_3032_start:
  call __function_gamepad_down
  mov R1, R0
  ieq R1, 1
  jf R1, __LogicalAnd_ShortCircuit_3037
  mov R2, [BP-8]
  ine R2, 1
  and R1, R2
__LogicalAnd_ShortCircuit_3037:
  mov R0, R1
  jf R0, __if_3032_end
  mov R0, 3
  mov [BP-9], R0
__if_3032_end:
__if_3020_end:
__if_3008_end:
__if_2996_end:
__if_3044_start:
  mov R2, [BP-13]
  mov R1, [R2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-10]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_3053
  mov R3, [BP-13]
  mov R2, [R3]
  iadd R2, 3
  mov R1, [R2]
  mov R2, [BP-11]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3053:
  jf R0, __if_3044_end
  call __function_rand
  mov R1, R0
  imod R1, 41
  imul R1, 15
  isgn R1
  iadd R1, 635
  mov [BP-10], R1
  mov R0, R1
  call __function_rand
  mov R1, R0
  imod R1, 24
  imul R1, 15
  isgn R1
  iadd R1, 360
  mov [BP-11], R1
  mov R0, R1
  mov R2, -100
  mov [SP], R2
  mov R2, -100
  mov [SP+1], R2
  call __function_mknode
  mov R1, R0
  mov [BP-14], R1
  mov R0, R1
  mov R2, [BP-13]
  mov [SP], R2
  mov R3, [BP-13]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  mov R2, [BP-14]
  mov [SP+2], R2
  call __function_append
  mov R1, R0
  mov [BP-13], R1
  mov R0, R1
__if_3044_end:
  mov R2, [BP-13]
  mov R1, [R2]
  mov R0, [R1]
  mov [BP-14], R0
__while_3096_start:
__while_3096_continue:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __while_3096_end
__if_3101_start:
  mov R2, [BP-13]
  mov R1, [R2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_3111
  mov R3, [BP-13]
  mov R2, [R3]
  iadd R2, 3
  mov R1, [R2]
  mov R3, [BP-14]
  iadd R3, 3
  mov R2, [R3]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3111:
  jf R0, __if_3101_end
  mov R0, 1
  mov [BP-7], R0
__if_3101_end:
  mov R1, [BP-14]
  mov R0, [R1]
  mov [BP-14], R0
  jmp __while_3096_start
__while_3096_end:
__if_3123_start:
  mov R2, [BP-13]
  mov R1, [R2]
  iadd R1, 2
  mov R0, [R1]
  ilt R0, 0
  jt R0, __LogicalOr_ShortCircuit_3132
  mov R3, [BP-13]
  mov R2, [R3]
  iadd R2, 2
  mov R1, [R2]
  igt R1, 640
  or R0, R1
__LogicalOr_ShortCircuit_3132:
  jf R0, __if_3123_end
  mov R0, 1
  mov [BP-7], R0
__if_3123_end:
__if_3139_start:
  mov R2, [BP-13]
  mov R1, [R2]
  iadd R1, 3
  mov R0, [R1]
  ilt R0, 0
  jt R0, __LogicalOr_ShortCircuit_3148
  mov R3, [BP-13]
  mov R2, [R3]
  iadd R2, 3
  mov R1, [R2]
  igt R1, 360
  or R0, R1
__LogicalOr_ShortCircuit_3148:
  jf R0, __if_3139_end
  mov R0, 1
  mov [BP-7], R0
__if_3139_end:
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R1, [BP-13]
  mov R0, [R1]
  mov [BP-14], R0
  mov R1, -16711936
  mov [SP], R1
  call __function_set_multiply_color
__if_3163_start:
  call __function_gamepad_button_b
  mov R1, R0
  igt R1, 0
  jf R1, __LogicalAnd_ShortCircuit_3168
  mov R2, [BP-12]
  ile R2, 9
  and R1, R2
__LogicalAnd_ShortCircuit_3168:
  mov R0, R1
  jf R0, __if_3163_end
  mov R1, -256
  mov [SP], R1
  call __function_set_multiply_color
__if_3163_end:
__while_3174_start:
__while_3174_continue:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __while_3174_end
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  isub R1, 6
  mov [SP], R1
  mov R2, [BP-14]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 6
  mov [SP+1], R1
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 6
  mov [SP+2], R1
  mov R2, [BP-14]
  iadd R2, 3
  mov R1, [R2]
  iadd R1, 6
  mov [SP+3], R1
  call __function_draw_filled_rectangle
  mov R1, [BP-14]
  mov R0, [R1]
  mov [BP-14], R0
  jmp __while_3174_start
__while_3174_end:
  mov R1, -16776961
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, [BP-10]
  isub R1, 7
  mov [SP], R1
  mov R1, [BP-11]
  isub R1, 7
  mov [SP+1], R1
  mov R1, [BP-10]
  iadd R1, 7
  mov [SP+2], R1
  mov R1, [BP-11]
  iadd R1, 7
  mov [SP+3], R1
  call __function_draw_filled_rectangle
  mov R2, [BP-13]
  iadd R2, 2
  mov R1, [R2]
  isub R1, 3
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, 0
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, __literal_string_3227
  mov [SP+2], R1
  call __function_print_at
  mov R1, 70
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  call __function_print_at
  call __function_end_frame
  jmp __while_2905_start
__while_2905_end:
  mov R0, 120
  mov [BP-12], R0
__while_3236_start:
__while_3236_continue:
  mov R0, [BP-12]
  igt R0, 0
  jf R0, __while_3236_end
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R2, [BP-13]
  mov R1, [R2]
  mov R0, [R1]
  mov [BP-14], R0
  mov R1, -16711936
  mov [SP], R1
  call __function_set_multiply_color
__while_3250_start:
__while_3250_continue:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __while_3250_end
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  isub R1, 6
  mov [SP], R1
  mov R2, [BP-14]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 6
  mov [SP+1], R1
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 6
  mov [SP+2], R1
  mov R2, [BP-14]
  iadd R2, 3
  mov R1, [R2]
  iadd R1, 6
  mov [SP+3], R1
  call __function_draw_filled_rectangle
  mov R1, [BP-14]
  mov R0, [R1]
  mov [BP-14], R0
  jmp __while_3250_start
__while_3250_end:
  mov R1, [BP-13]
  mov R0, [R1]
  mov [BP-14], R0
__if_3280_start:
  mov R0, [BP-12]
  imod R0, 60
  ile R0, 30
  jf R0, __if_3280_else
  mov R1, -16776961
  mov [SP], R1
  call __function_set_multiply_color
  jmp __if_3280_end
__if_3280_else:
  mov R1, -16711936
  mov [SP], R1
  call __function_set_multiply_color
__if_3280_end:
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  isub R1, 6
  mov [SP], R1
  mov R2, [BP-14]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 6
  mov [SP+1], R1
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 6
  mov [SP+2], R1
  mov R2, [BP-14]
  iadd R2, 3
  mov R1, [R2]
  iadd R1, 6
  mov [SP+3], R1
  call __function_draw_filled_rectangle
  mov R1, [BP-14]
  mov R0, [R1]
  mov [BP-14], R0
  mov R1, -16776961
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, [BP-10]
  isub R1, 7
  mov [SP], R1
  mov R1, [BP-11]
  isub R1, 7
  mov [SP+1], R1
  mov R1, [BP-10]
  iadd R1, 7
  mov [SP+2], R1
  mov R1, [BP-11]
  iadd R1, 7
  mov [SP+3], R1
  call __function_draw_filled_rectangle
  call __function_end_frame
  mov R0, [BP-12]
  mov R1, R0
  isub R1, 1
  mov [BP-12], R1
  jmp __while_3236_start
__while_3236_end:
__while_3331_start:
__while_3331_continue:
  call __function_gamepad_button_b
  mov R1, R0
  ine R1, 2
  mov R0, R1
  jf R0, __while_3331_end
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R1, 275
  mov [SP], R1
  mov R1, 170
  mov [SP+1], R1
  mov R1, __literal_string_3341
  mov [SP+2], R1
  call __function_print_at
__if_3342_start:
  call __function_get_frame_counter
  mov R1, R0
  imod R1, 90
  ilt R1, 45
  mov R0, R1
  jf R0, __if_3342_end
  mov R1, 230
  mov [SP], R1
  mov R1, 190
  mov [SP+1], R1
  mov R1, __literal_string_3352
  mov [SP+2], R1
  call __function_print_at
__if_3342_end:
  call __function_end_frame
  jmp __while_3331_start
__while_3331_end:
  mov R2, [BP-13]
  mov [SP], R2
  call __function_clearlist
  mov R1, R0
  mov [BP-13], R1
  mov R0, R1
  mov R0, 0
  mov [BP-7], R0
  jmp __while_2811_start
__while_2811_end:
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
__literal_string_2884:
  string "Get all the apples!"
__literal_string_2888:
  string "Use the D-Pad to move"
__literal_string_2892:
  string "Hold B to activate turbo mode"
__literal_string_2903:
  string "Press B to start"
__literal_string_3227:
  string "Points:"
__literal_string_3341:
  string "You Died!"
__literal_string_3352:
  string "Press B to restart"
