extends Control

@export var skill_button_scene: PackedScene
const DISTANCIA_VERTICAL = 20
const PADDING_MINIMO = 20
var skills = {} 
var skill_tree_data = {
	0: ["salto_doble"],
	1: ["dash", "disparo"],
	2: ["ataque_cargado", "explosion", "vuelo"],
	3: ["disparo_triple", "super_dash"]
}
var skill_links = {
	"salto_doble": ["dash", "disparo"],
	"dash": ["ataque_cargado"],
	"disparo": ["explosion", "vuelo"],
	"ataque_cargado": ["disparo_triple"],
	"explosion": ["disparo_triple", "super_dash"],
	"disparo_triple": [],
	"super_dash": []
}
func _ready():
	construir_arbol(skill_tree_data)


func construir_arbol(data: Dictionary):
	var skill_vbox = $SkillVbox
	skill_vbox.add_theme_constant_override("separation", DISTANCIA_VERTICAL)
	# limpiar árbol previo
	for child in skill_vbox.get_children():
		child.queue_free()

	for nivel in data.keys():
		var lista = data[nivel]
		var hbox = HBoxContainer.new()
		hbox.name = "Nivel_%d" % nivel
		hbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		hbox.add_theme_constant_override("separation", PADDING_MINIMO)
		skill_vbox.add_child(hbox)

		for hab_id in lista:
			_crear_boton(hab_id, hbox)
	# redibujar líneas de conexión
	$LineLayer.queue_redraw()

func _crear_boton(habilidad_id: String, contenedor: Control):
	var boton = skill_button_scene.instantiate()
	boton.text = habilidad_id.capitalize()
	contenedor.add_child(boton)
	skills[habilidad_id] = boton

	# conectar señales del botón si las tienes
	if boton.has_signal("skill_unlocked"):
		boton.skill_unlocked.connect(_on_skill_unlocked)
	if boton.has_signal("skill_locked"):
		boton.skill_locked.connect(_on_skill_locked)

func _on_skill_unlocked(skill_id): pass
func _on_skill_locked(skill_id): pass
