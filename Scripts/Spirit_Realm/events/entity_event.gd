extends BaseEvent
class_name EntityEvent

var entity_id : int
var place : Array[Vector2]
var extra_data : Array[EventData] = []

func _init(event_type: GlobalEnums.event_type, entity: int, place: Array[Vector2]) -> void:
	self.event_type = event_type
	self.entity_id = entity
	self.place = place

func _get_type_str(t):
	if t == GlobalEnums.event_type.MOVE:
		return "move"
	if t == GlobalEnums.event_type.COLLISION:
		return "collision"
	if t == GlobalEnums.event_type.HIT:
		return "hit"
	if t == GlobalEnums.event_type.DEATH:
		return "death"
	return "Unknown Event"

func get_type_as_str() -> String:
	if event_type == GlobalEnums.event_type.MOVE:
		return "Move"
	if event_type == GlobalEnums.event_type.COLLISION:
		return "Collision"
	if event_type == GlobalEnums.event_type.HIT:
		return "Hit"
	if event_type == GlobalEnums.event_type.DEATH:
		return "Death"
	return "UNKNOWN"

func _to_string():
	return "Event: " +  get_type_as_str() + " Target: " + str(entity_id) + " place " + str(place)

func affects_target_with_id(entity:BoardEntity) -> bool:
	return entity_id == entity.character_id

func add_data(data: EventData):
	extra_data.append(data)
