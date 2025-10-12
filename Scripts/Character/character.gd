extends Node
class_name Character

@onready var visual : VisualCharacter

@onready var actions : Array[BaseAction] = [ DashAction.new(), ThrustAction.new(), SlowDashAttack.new(), SummonProjectileAction.new() ]
var is_ai = false

@onready var controller : CharacterController
var spirit : BoardEntity = null
@export var debug_display: String = "C"
@export var x_pos = 2
@export var y_pos = 2

func _init():
	print(self)

func initialize():
	self.spirit = BoardEntity.new(x_pos, y_pos)
	self.spirit.debug_display = self.debug_display
	GlobalComponents.abstract_board.place_entity(spirit)
	self.controller.link_spirit(self.spirit)
	self.visual.position = VisualBoardTools.spirit_tile_into_visual(Vector2(x_pos, y_pos))
	visual.is_keyboard = controller.controls.is_keyboard
	spirit.destroyed.connect(death)
	spirit.new_events.connect(transfer_events)
	##initialize and place visual character on board

func death() -> void:
	queue_free()	

func set_action(index: int, action: BaseAction):
	self.controller.actions[index] = action

func _ready() -> void:
	self.visual = $VisualCharacter
	self.controller = $PlayerController
	initialize()

func transfer_events(events):
	self.visual.new_orders(events)

func get_spirit_position() -> Coordinates:
	return self.spirit.coordinates
