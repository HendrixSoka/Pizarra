class_name SkillTree
extends Control

var array_buttons: Array[TextureButton]

func _ready() -> void:
	var buttons: Array = find_children("*", "Button", true, false)
	for button in buttons:
		array_buttons.append(button)
		button.connect("pressed",Callable(self,"pressed"))

func pressed():
	for buttons in array_buttons.size():
		pass
