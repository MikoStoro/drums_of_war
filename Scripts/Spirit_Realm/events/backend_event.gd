extends Node
class_name BackendEvent

func _get_type_str(t):
	if t == GlobalEnums.backend_event_type.INPUT:
		return "input"
	return "Unknown Event"

func _to_string():
	return "Backend Event: " +  _get_type_str(type) + " target: " + str(object) + " " + str(place)
