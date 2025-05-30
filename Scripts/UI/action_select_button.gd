extends Node

var actions_dict=[]

func _ready() -> void:
	var i = 0	
	for child:OptionButton in get_children():
		for action:BaseAction in Character_Manager.character.actions:
			child.add_item(action.action_name)
			actions_dict.append(action)
			if Character_Manager.character.actions[i] == action:
				child.selected = i
		i+=1


func _on_action_item_selected(index: int) -> void:
	Character_Manager.character.actions[0] = actions_dict[index]


func _on_action_2_item_selected(index: int) -> void:
	Character_Manager.character.actions[1] = actions_dict[index]


func _on_action_3_item_selected(index: int) -> void:
	Character_Manager.character.actions[2] = actions_dict[index]


func _on_action_4_item_selected(index: int) -> void:
	Character_Manager.character.actions[3] = actions_dict[index]
