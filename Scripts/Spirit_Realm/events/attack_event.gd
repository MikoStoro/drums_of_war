extends BaseEvent
class_name AttackEvent

var attack_id : int
var location_list : Array[Vector2] # order of coordinates is important

func _init(event_type: String, attack_id: int, location_list: Array[Vector2]) -> void:
	self.event_type = event_type
	self.attack_id = attack_id
	self.location_list = location_list
