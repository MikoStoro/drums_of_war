class_name BaseAction extends Node

var action_name = "base_action"

func rotate_moves(direction: int):
	for m in self.moves:
		m.rotate(direction)


func perform_action(entity : BoardEntity, direction: int = 0):
	pass

func end_action(character):
	pass
