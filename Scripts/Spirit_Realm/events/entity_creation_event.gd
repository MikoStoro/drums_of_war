extends BaseEvent
class_name EntityCreationEvent

var entity_id : int
var entiity_display_id : int

func _init(entity_id : int, entity_display_id : int) -> void:
	self.event_type = GlobalEnums.event_type.ENTITY_SPAWN
	self.entity_id = entity_id
	self.entiity_display_id = entiity_display_id

func get_type_as_str() -> String:
	return "Entity Creation"
