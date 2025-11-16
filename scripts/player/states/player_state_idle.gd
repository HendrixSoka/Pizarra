extends PlayerStateBase

func start():
	player.sprite.play(player.animations.idle)

func on_physics_process(delta: float) -> void:
	super(delta)
	player.handle_external_forces(delta)
	player.handle_gravity(delta)
	player.handle_rotation(player.get_axis())
	var perp = player.gravity_direction.rotated(PI/2)
	if perp.dot(Vector2(1,0)) < 0:
		perp = -perp
	var current_speed = player.velocity.dot(perp)
	player.move_to(0, 0, abs(current_speed * 6.25), delta)
	
	if player.get_axis():
		state_machine.change_to(player.states.walk)
		return
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to(player.states.jump)
		return
	
func end():
	pass
