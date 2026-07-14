extends BaseEvent
class_name EntityCreationEvent

var entity_id : int
var entity_display_id : int
var place : Vector2

func _init(entity_id : int, entity_display_id : int, place: Vector2) -> void:
	self.event_type = EventTypes.ENTITY_SPAWN
	self.entity_id = entity_id
	self.entity_display_id = entity_display_id
	self.place = place
