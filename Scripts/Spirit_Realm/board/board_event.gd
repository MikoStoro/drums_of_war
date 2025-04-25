class_name BoardEvent

enum Event_type {CLASH, HIT ,COLLISION ,MOVE }

var object : Variant = null
var type: Event_type
var place : Coordinates = null

func _init(type: Event_type, object, place: Coordinates) -> void:
	self.type = type
	self.object = object
	self.place = place

func _to_string():
	return "Event: " + str(type) + " Object: " + str(object) + " " + str(place)
