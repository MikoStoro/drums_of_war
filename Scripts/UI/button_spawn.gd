extends Button
@export var x:TextEdit
@export var y:TextEdit
@export var is_ai:CheckBox
func _on_button_down() -> void:
	var z: Character_Manager = get_tree().get_first_node_in_group("CharacterManager")
	var pos = {"x" = int(x.text), "y" = int(y.text)}
	if is_ai.button_pressed:
		z.add_npc(GlobalEnums.npc_type.charger, pos)
	z.add_character(pos)
	#z.add_character(y.text.to_int(),x.text.to_int())
