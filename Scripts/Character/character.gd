extends Node
class_name AbstractCharacter

@onready var actions : Array[BaseAction] = [ DashAction.new(), ThrustAction.new(), SlowDashAttack.new(), SummonProjectileAction.new() ]
var is_ai = false

var spirit : BoardEntity = null
@export var debug_display: String = "C"
@export var x_pos = 0
@export var y_pos = 0

var data = null

var id: int

func _init():
	self.id = ResourceUID.create_id()
	print(self)

func setup_entity():
	if data != null: ## in case entity was not spawned but existed since the start of the game 
		self.x_pos = data['x'] ## TODO - maybe the coordinates should be added when character is baing placed on board?
		self.y_pos = data['y']
	self.spirit = BoardEntity.new(x_pos, y_pos)
	self.spirit.debug_display = self.debug_display
	#GlobalComponents.abstract_board.place_entity(spirit) ## links to board are ugh
	spirit.destroyed.connect(destruction)

func destruction() -> void:
	ResourceUID.remove_id(self.id)
	queue_free()	

func set_action(index: int, action: BaseAction):
	self.controller.actions[index] = action

func _ready() -> void:
	pass
	# copied to setup func
	setup_entity()

func get_spirit_position() -> Coordinates:
	return self.spirit.coordinates
	
func setup(data : Dictionary):
	self.data = data
	
	setup_entity()
