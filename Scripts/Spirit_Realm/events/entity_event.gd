extends BaseEvent
class_name EntityEvent

var entity_id : int
var place : Array[Vector2]
var extra_data : Array[EventData] = []

func _init(event_type: String, entity: int, place: Array[Vector2]) -> void:
	self.event_type = event_type
	self.entity_id = entity
	self.place = place

func _get_type_str(t):
	if t == EventTypes.MOVE:
		return "move"
	if t == EventTypes.COLLISION:
		return "collision"
	if t == EventTypes.HIT:
		return "hit"
	if t == EventTypes.DEATH:
		return "death"
	return "Unknown Event"


func _to_string():
	return "Event: " +  event_type + " Target: " + str(entity_id) + " place " + str(place)

func affects_target_with_id(entity:BoardEntity) -> bool:
	return entity_id == entity.character_id

func add_data(data: EventData):
	extra_data.append(data)
