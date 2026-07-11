class_name AbstractCharacter

var actions : Array[BaseAction] = [ DashAction.new(), ThrustAction.new(), SlowDashAttack.new(), SummonProjectileAction.new() ]
var is_ai = false

var spirit : BoardEntity = null
@export var debug_display: String = "C"
var controller : AbstractCharacterBaseController

var id: int

func _init(custom_id = null):
	if custom_id != null and typeof(custom_id) == TYPE_INT:
		self.id = custom_id 
	else: self.id = ResourceUID.create_id()
	self.spirit = BoardEntity.new(self.id, debug_display)
	self.spirit.destroyed.connect(destruction)
	print(self)

func destruction() -> void:
	ResourceUID.remove_id(self.id)

func set_action(index: int, action: BaseAction):
	self.controller.actions[index] = action

func get_spirit_position() -> Coordinates:
	return self.spirit.coordinates

func perform_action(index: int):
	self.spirit.act
