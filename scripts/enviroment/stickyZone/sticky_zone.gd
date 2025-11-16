extends Node2D

@export var gravity_direction: Vector2 = Vector2(0, -1)  # ejemplo: gravedad hacia arriba

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body is Player:
		body.set_custom_gravity(gravity_direction)

func _on_body_exited(body):
	if body is Player:
		body.reset_gravity()
