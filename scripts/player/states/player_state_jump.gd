extends PlayerStateBase

func start():
	player.sprite.play(player.animations.jump)
	player.jump_potency = 1
	player.jump_timer = player.JUMP_DURATION
	player.jump_to()
	player.squash_tween()

func on_physics_process(delta: float) -> void:
	super(delta)
	player.handle_gravity(delta)
	player.handle_rotation(player.get_axis())
	player.move_to(player.get_axis(),player.speed_force,player.speed_force * 12.5,delta)
	
	if Input.is_action_pressed("jump") and  player.jump_timer > 0:
		player.jump_timer -= delta
		player.jump_potency += delta * 5 
		player.jump_to(player.jump_potency)
	elif !Input.is_action_pressed("jump"):
		player.jump_timer = 0
	
	if player.velocity.y >= 0:
		state_machine.change_to(player.states.fall)	
		return
	
func end():
	pass
