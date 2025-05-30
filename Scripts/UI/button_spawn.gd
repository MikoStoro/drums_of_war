extends Button


func _on_button_down() -> void:
	var z= get_tree().get_first_node_in_group("CharacterManager")
	z.add_character(1,1)
