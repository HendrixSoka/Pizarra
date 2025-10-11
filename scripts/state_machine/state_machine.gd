class_name StateMachine 
extends Node

# -- Properties
@onready var controlled_node = self.owner
@export var default_state: StateBase

var last_state: StateBase
var current_state: StateBase

# -- Godot Lifecycle Methods
func _ready() -> void:
	# Defer default state setup
	call_deferred("_set_default_state")

func _physics_process(delta: float) -> void:
	# Call current state's physics process
	if current_state and current_state.has_method("on_physics_process"):
		current_state.on_physics_process(delta)

func _process(delta: float) -> void:
	# Call current state's process
	if current_state and current_state.has_method("on_process"):
		current_state.on_process(delta)

func _unhandled_input(event: InputEvent) -> void:
	# Pass unhandled input to current state
	if current_state and current_state.has_method("on_unhandled_input"):
		current_state.on_unhandled_input(event)

# -- State Management
func _set_default_state():
	# Initialize default state
	if !current_state:
		last_state = default_state
		current_state = default_state
		_start_state_machine()

func _start_state_machine():
 	# Set up and start current state
	current_state.state_machine = self
	current_state.start()

func change_to(NewState : String):
	# Transition to a new state
	last_state = current_state
	if current_state:
		current_state.end()
	current_state = get_node(NewState)
	_start_state_machine()
