extends Node

func _ready() -> void:
	for child:OptionButton in get_children():
		#init character
		for action:BaseAction in Character_Manager.character.actions:
			child.add_item(action.action_name)
