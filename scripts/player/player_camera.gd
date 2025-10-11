class_name PlayerCamera
extends Camera2D

@onready var player: Player = self.owner

func _ready() -> void:
	global_position = Vector2(player.global_position.x, player.global_position.y - 16)

func _physics_process(_delta: float) -> void:
	global_position = global_position.lerp(Vector2(player.global_position.x, player.global_position.y - 16), 0.075)
