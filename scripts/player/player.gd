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

var external_force: Vector2 = Vector2.ZERO
var external_force_timer: float = 0
var gravity_direction: Vector2 = Vector2(0, 1)

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
		var vel_grav = velocity.dot(gravity_direction)
		vel_grav = clamp(vel_grav + gravity_force * delta, -gravity_force, gravity_force * 0.325)
		velocity = velocity - gravity_direction * velocity.dot(gravity_direction)
		velocity += gravity_direction * vel_grav

func move_to(direction: int, speed_potency: float, amount: float, delta: float):
	var perp := gravity_direction.rotated(-PI / 2.0)
	if perp.dot(Vector2(1,0)) < 0:
		perp = -perp
	var current_speed := velocity.dot(perp)
	var target_speed := direction * speed_potency
	var new_speed := move_toward(current_speed, target_speed, amount * delta)
	velocity += perp * (new_speed - current_speed)


func jump_to(potency := 1.0):
	var lateral = velocity - gravity_direction * velocity.dot(gravity_direction)
	velocity = lateral + (-gravity_direction * jump_force * potency)


func handle_rotation(direction: int):
	if direction != 0 and graphics.scale.x != direction:
		graphics.scale.x = direction
		squash_tween()
	update_sprite_rotation()

func update_sprite_rotation() -> void:
	graphics.rotation = gravity_direction.angle() - PI / 2

func get_axis():
	return sign(Input.get_axis("left","right"))

func squash_tween():
	var tween = create_tween()
	tween.tween_property(sprite_container, "scale", Vector2(1.15, 0.85), 0.075)
	tween.tween_property(sprite_container, "scale", Vector2(1, 1), 0.075)

func apply_external_force(force: Vector2, duration: float):
	external_force = force
	external_force_timer = duration
func handle_external_forces(delta):
	if external_force_timer > 0:
		if abs(external_force.y) > abs(velocity.y):
			velocity.y += external_force.y * delta * 1.6  # multiplica para que domine
		else:
			velocity.y += external_force.y * delta
		velocity.x += external_force.x * delta
		external_force_timer -= delta
		if external_force_timer <= 0:
			external_force = Vector2.ZERO

func set_custom_gravity(direction: Vector2):
	var lateral = velocity - gravity_direction * velocity.dot(gravity_direction)
	gravity_direction = direction.normalized()
	up_direction = -gravity_direction
	velocity = lateral
func reset_gravity():
	gravity_direction = Vector2(0,1)
	up_direction = Vector2(0,-1)
