extends Button

# Variables públicas para configurar el botón
@export var skill_id: String
@export var skill_name: String = ""
@export var unlocked: bool = false

# Señales para avisar al árbol principal
signal skill_unlocked(skill_id)
signal skill_locked(skill_id)

func _ready():
	# Opcional: cambia el color o el texto según el estado
	_update_visual_state()
	connect("pressed", _on_pressed)

func _on_pressed():
	# Alternar el estado al hacer clic
	unlocked = !unlocked
	_update_visual_state()

	if unlocked:
		emit_signal("skill_unlocked", skill_id)
	else:
		emit_signal("skill_locked", skill_id)

func _update_visual_state():
	# Puedes cambiar el color o texto según si está activa o no
	if unlocked:
		self.text = "yes " + skill_name
	else:
		self.text = "no " + skill_name
