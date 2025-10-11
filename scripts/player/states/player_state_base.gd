class_name PlayerStateBase
extends StateBase

var player: Player:
	get:
		return state_machine.controlled_node
		
func on_physics_process(_delta: float) -> void:
	player.move_and_slide()
