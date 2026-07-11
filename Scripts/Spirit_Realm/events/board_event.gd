class_name BoardEvent

var target_id : String
var type: GlobalEnums.event_type
var place : Array[Vector2]
var extra_data : Array[EventData] = []

func _init(type: GlobalEnums.event_type, target: String, place: Array[Vector2]) -> void:
	self.type = type
	self.target_id = target
	self.place = place

func _get_type_str(t):
	if t == GlobalEnums.event_type.MOVE:
		return "move"
	if t == GlobalEnums.event_type.COLLISION:
		return "collision"
	if t == GlobalEnums.event_type.ATTACK:
		return "attack"
	if t == GlobalEnums.event_type.HIT:
		return "hit"
	if t == GlobalEnums.event_type.DEATH:
		return "death"
	return "Unknown Event"


func _to_string():
	return "Event: " +  _get_type_str(type) + " Target: " + target_id + " place " + str(place)

func affects_target_with_id(entity:BoardEntity) -> bool:
	if type == GlobalEnums.event_type.ATTACK:
		return (object as Attack).user == entity
	if type == GlobalEnums.event_type.MOVE:
		return object == entity
	if type == GlobalEnums.event_type.HIT:
		return object == entity
	if type == GlobalEnums.event_type.COLLISION:
		return  object == entity
	else: return false

func get_affected_entities():
	if type == GlobalEnums.event_type.ATTACK:
		return (object as Attack).user
	if type == GlobalEnums.event_type.MOVE:
		return object
	if type == GlobalEnums.event_type.COLLISION:
		return object
	if type == GlobalEnums.event_type.HIT:
		return object
	else: return null

func add_data(data: EventData):
	extra_data.append(data)
