class_name Player
extends CharacterBody2D

@export var gravity_force: float = 980
@export var speed_force: float = 150
@export var jump_force: float = 125

@onready var sprite: AnimatedSprite2D = $Graphics/SpriteContainer/Sprite
@onready var graphics: Node2D = $Graphics
@onready var sprite_container: Node2D = $Graphics/SpriteContainer

const JUMP_DURATION: float = 0.2
var jump_timer: float = JUMP_DURATION
var jump_potency: float = 1

const INPUT_BUFFER_DURATIONR: float = 0.25
var input_buffer_timer: float = INPUT_BUFFER_DURATIONR
var input_buffer: String

const animations: Dictionary = {
	idle = "idle",
	walk = "walk",
	run = "run",
	jump = "jump",
	fall = "fall"
}

const states: Dictionary = {
	idle = "Idle",
	walk = "Walk",
	jump = "Jump",
	fall = "Fall"
}

func handle_gravity(delta: float):
	if !is_on_floor():
		velocity.y = clamp(velocity.y + gravity_force * delta, -gravity_force, gravity_force * 0.325)

func move_to(direction: int, speed_potency: float, amount: float, delta: float):
	velocity.x = move_toward(velocity.x, direction * speed_potency, amount * delta)

func jump_to(potency: float = 1):
	velocity.y = -jump_force * potency

func handle_rotation(direction: int):
	if graphics.transform.x.x != direction and direction:
		graphics.transform.x.x = direction
		squash_tween()

func get_axis():
	return sign(Input.get_axis("left","right"))

func squash_tween():
	var tween = create_tween()
	tween.tween_property(sprite_container, "scale", Vector2(1.15, 0.85), 0.075)
	tween.tween_property(sprite_container, "scale", Vector2(1, 1), 0.075)
	
