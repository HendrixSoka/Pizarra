extends Node2D

@export var speed : float
@export var direction : Vector2
@export var duration : float

func _ready():
	$Wind_area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is Player:
		body.apply_external_force(direction * speed, duration)
