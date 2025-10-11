extends PlayerStateBase

func start():
	player.input_buffer_timer = player.INPUT_BUFFER_DURATIONR
	player.sprite.play(player.animations.fall)

func on_physics_process(delta: float) -> void:
	super(delta)
	player.handle_gravity(delta)
	player.handle_rotation(player.get_axis())
	player.move_to(player.get_axis(),player.speed_force,player.speed_force * 12.5,delta)
	
	if Input.is_action_just_pressed("jump"):
		player.input_buffer = player.states.jump
	
	if player.input_buffer != "":
		player.input_buffer_timer -= delta
		if player.input_buffer_timer <= 0:
			player.input_buffer = " "
	
	if player.is_on_floor():
		match player.input_buffer:
			player.states.jump:
				state_machine.change_to(player.states.jump)
				return
		state_machine.change_to(player.states.idle)
		return
	
func end():
	player.input_buffer = ""
