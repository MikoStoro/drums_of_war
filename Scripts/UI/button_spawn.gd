extends Button
@export var x:TextEdit
@export var y:TextEdit

func _on_button_down() -> void:
	var z: Character_Manager = get_tree().get_first_node_in_group("CharacterManager")
	z.add_npc(GlobalEnums.npc_type.charger, {"x" = int(x.text), "y" = int(y.text)})
	#z.add_character(y.text.to_int(),x.text.to_int())
