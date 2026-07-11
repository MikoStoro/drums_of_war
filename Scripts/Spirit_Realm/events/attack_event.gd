extends BaseEvent

var attack_id : int
var place : Coordinates

func _init(event_type: GlobalEnums.event_type, attack_id: int, place: Coordinates) -> void:
	self.event_type = event_type
	self.attack_id = attack_id
	self.place = place
	
func get_type_as_str() -> String:
	if event_type == GlobalEnums.event_type.ATTACK_PROGRESS:
		return "Attack Progress"
	elif  event_type == GlobalEnums.event_type.ATTACK_CLASH:
		return "Attack Clash"
	else: return "UNKNOWN"
