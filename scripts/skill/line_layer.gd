extends Control

@onready var skill_tree = $".."  # referencia al nodo padre

func _draw():
	var skills = skill_tree.skills  
	var links = skill_tree.skill_links 
	
	for parent_name in links.keys():
		var parent_btn = skills.get(parent_name)
		if not parent_btn:
			continue
			
		for child_name in links[parent_name]:
			var child_btn = skills.get(child_name)
			if not child_btn:
				continue
			
			# Posiciones globales de los botones
			var from = parent_btn.get_global_position() + Vector2(parent_btn.size.x / 2, parent_btn.size.y)
			var to = child_btn.get_global_position() + Vector2(child_btn.size.x / 2, 0)
			
			# Convertir a coordenadas locales del LineLayer
			from -= global_position
			to -= global_position
			
			# Dibujar línea
			draw_line(from, to, Color(0.7, 0.7, 0.7), 3)

func _process(_delta):
	queue_redraw()
