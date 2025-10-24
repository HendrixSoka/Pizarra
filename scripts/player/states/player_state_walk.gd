extends PlayerStateBase

func start():
	player.sprite.play(player.animations.walk)

func on_physics_process(delta: float) -> void:
	super(delta)
	player.handle_external_forces(delta)
	player.handle_gravity(delta)
	player.handle_rotation(player.get_axis())
	player.move_to(player.get_axis(),player.speed_force,player.speed_force * 12.5,delta)

	if !player.get_axis():
		state_machine.change_to(player.states.idle)
		return
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to(player.states.jump)
		return

func end():
	pass
