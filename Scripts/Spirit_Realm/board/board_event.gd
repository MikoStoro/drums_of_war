class_name BoardEvent

#enum Event_type {CLASH,HIT,COLLISION,MOVE}

var object : Variant = null
var type: GlobalEnums.event_type
var place : Vector2

func _init(type: GlobalEnums.event_type, object, place: Vector2) -> void:
	self.type = type
	self.object = object
	self.place = place

func _to_string():
	return "Event: " + str(type) + " Object: " + str(object) + " " + str(place)
