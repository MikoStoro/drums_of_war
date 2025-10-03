extends Node
class_name Character

@onready var visual : VisualCharacter
@onready var controller : CharacterController
var spirit : BoardEntity = null
@onready var actions : Array[BaseAction] = [ DashAction.new(), ThrustAction.new(), CleaveAction.new(), QuickStabAction.new() ]
var is_ai = false

var debug_display: String = "C"
var x_pos = 2
var y_pos = 2

func _init():
	print(self)

func initialize():
	self.spirit = BoardEntity.new(x_pos, y_pos)
	self.spirit.debug_display = self.debug_display
	GlobalComponents.abstract_board.place_entity(spirit)
	self.controller.link_spirit(self.spirit)
	self.visual.position = VisualBoardTools.spirit_tile_into_visual(Vector2(x_pos, y_pos))
	visual.is_keyboard = controller.controls.is_keyboard
	##initialize and place visual character on board
	
func set_action(index: int, action: BaseAction):
	self.controller.actions[index] = action

func _ready() -> void:
	var children  = self.get_children()
	if(len(children)>0):
		self.controller = children[0] # By the Omnissiah, what caused the sacred sigil of the Dolarius not enact its function?
		self.visual = children[1]
		initialize()

func get_spirit_position() -> Coordinates:
	return self.spirit.coordinates
