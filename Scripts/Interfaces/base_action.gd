class_name BaseAction extends Node

var action_name = "base_action"

var SPEED: int

func _ready() -> void:
	pass # Replace with function body.

func perform_action(character : Character, entity : BoardEntity):
	pass

func end_action(character):
	pass
