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

var data = null

func _init():
	print(self)

func setup_entity():
	if data != null: ## in case entity was not spawned but existed since the start of the game 
		self.x_pos = data['x']
		self.y_pos = data['y']
	self.spirit = BoardEntity.new(x_pos, y_pos)
	self.spirit.debug_display = self.debug_display
	GlobalComponents.abstract_board.place_entity(spirit)
	self.controller.link_spirit(self.spirit)
	spirit.destroyed.connect(destruction)
	spirit.new_events.connect(transfer_events)

func destruction() -> void:
	queue_free()	

func set_action(index: int, action: BaseAction):
	self.controller.actions[index] = action

func _ready() -> void:
	pass
	# moved to setup func
	#self.visual = $VisualCharacter
	#self.controller = $PlayerController
	#setup_entity()
	#setup_visual()

func transfer_events(events):
	self.visual.new_orders(events)

func get_spirit_position() -> Coordinates:
	return self.spirit.coordinates
	
func setup_visual():
	visual.is_keyboard = controller.controls.is_keyboard
	self.visual.place(x_pos, y_pos)
	
func setup(data : Dictionary):
	self.data = data
	
	self.visual = $VisualCharacter
	self.controller = $PlayerController
	setup_entity()
	setup_visual()
