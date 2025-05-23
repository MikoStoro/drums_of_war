extends Attack
class_name QuickStabAttack

func _init(rotation:int = 0) -> void:
	self.name = "Quick Stab"
	target_blueprint = [
		Coordinates.new(1,0),
	]
	self.priority = 2
	self.rotate(rotation)
