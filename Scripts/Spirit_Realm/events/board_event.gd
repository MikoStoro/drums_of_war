class_name BoardEvent

var object : Variant = null
var type: GlobalEnums.event_type
var place : Array[Vector2]
var extra_data : Array[EventData] = []

func _init(type: GlobalEnums.event_type, object, place: Array[Vector2]) -> void:
	self.type = type
	self.object = object
	self.place = place

func _to_string():
	return "Event: " + str(type) + " Object: " + str(object) + " " + str(place)

func affects_entity(entity:BoardEntity) -> bool:
	if type == GlobalEnums.event_type.ATTACK:
		return (object as Attack).user == entity
	if type == GlobalEnums.event_type.MOVE:
		return object == entity
	if type == GlobalEnums.event_type.COLLISION or type == GlobalEnums.event_type.HIT:
		return (object as Array).has(entity)
	else: return false

func get_affected_entities():
	if type == GlobalEnums.event_type.ATTACK:
		return (object as Attack).user
	if type == GlobalEnums.event_type.MOVE:
		return object
	if type == GlobalEnums.event_type.COLLISION:
		return object
	if type == GlobalEnums.event_type.HIT:
		return object[0]
	else: return null

func add_data(data: EventData):
	extra_data.append(data)
