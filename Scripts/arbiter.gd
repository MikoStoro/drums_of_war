extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalComponents.abstract_board.reset_board()
	$"../CharacterManager".add_child(Character.new())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
