extends Node
class_name Character

@onready var visual : VisualCharacter = $VisualCharacter
@onready var controller : CharacterController = $CharacterController
var spirit : BoardEntity = null


func _init():
	pass

func create(s_x: int = 0, s_y:int = 0):
	var spirit = BoardEntity.new(s_x, s_y)
	GlobalComponents.abstract_board.place_entity(spirit)
	var player: VisualCharacter = find_child("VisualCharacter")
	player.position = GameManager.spirit_tile_into_visual(Vector2(s_x, s_y))
	##initialize and place visual character on board
	self
	
func set_action():
	## switch given action characterController (cerate an instance of action)
	pass
	

func _ready() -> void:
	create(1,1)
