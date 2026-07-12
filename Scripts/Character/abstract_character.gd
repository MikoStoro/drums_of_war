class_name AbstractCharacter


var is_ai = false

var spirit : BoardEntity = null
var display_id : int = -1 # this links abstract character to visual skin
@export var debug_display: String = "C"
var id: int
var current_action : BaseAction = null
var current_action_direction : int = 0

func _init(custom_id = null):
	if custom_id != null and typeof(custom_id) == TYPE_INT:
		self.id = custom_id 
	else: self.id = ResourceUID.create_id()
	self.spirit = BoardEntity.new(self.id, debug_display)
	self.spirit.destroyed.connect(destruction)
	print(self)

func destruction() -> void:
	ResourceUID.remove_id(self.id)

func get_spirit_position() -> Coordinates:
	return self.spirit.coordinates
	
func perform_action():
	self.current_action.perform_action(self.spirit, self.current_action_direction)

func reset_action():
	self.current_action = null
