class_name Attack_Result

var damage_taken : int = 1
var type : GlobalEnums.hit_result = GlobalEnums.hit_result.DAMAGE

func _init(damage = 1, type = GlobalEnums.hit_result.DAMAGE) -> void:
	self.damage_taken = damage
	self.type = type
