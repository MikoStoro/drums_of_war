class_name BaseEvent

var event_type : GlobalEnums.event_type = GlobalEnums.event_type.BASE

func get_type() -> GlobalEnums.event_type:
	return event_type
	
func get_type_as_str() -> String:
	return "Base"
