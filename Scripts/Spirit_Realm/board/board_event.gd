class_name BoardEvent

#enum Event_type {CLASH,HIT,COLLISION,MOVE}

var object : Variant = null
var type: GlobalEnums.event_type
var place : Coordinates = null

func _init(type: GlobalEnums.event_type, object, place: Coordinates) -> void:
	self.type = type
	self.object = object
	self.place = place
