extends BaseEvent
class_name PlayerInputEvent

var target_entity_id : int
var action_index : int
var action_direction : int 

func _init(character_id: int, action_index: int, direction : int) -> void:
	self.target_entity_id = character_id
	self.action_index = action_index
	self.action_direction = direction

func get_type_as_str():
	return "input"

func _to_string():
	return "Input Event: "  +  get_type_as_str() + " target: " + str(target_entity_id)  + " action: " + str(action_index) + " direction: " + str(action_direction)
