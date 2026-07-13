extends BaseEvent
class_name AttackCreationEvent

var attack_id : int #the id of created attack
var attack_display_id : int # lookup value for the attack - so you know what to display
var user_id: int # id of the character that used the attack 

func _init(attack_id: int, attack_display_id: int, user_id):
	self.event_type = GlobalEnums.event_type.ATTACK_CREATION
	self.attack_id = attack_id
	self.attack_display_id = attack_display_id
	self.user_id = user_id

func get_type_as_str() -> String:
	return "Attack Creation"
