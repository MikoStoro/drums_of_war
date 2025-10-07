extends Attack
class_name SlowStabAttack

func _init(rotation:int = 0) -> void:
	self.name = "Slow Stab"
	target_blueprint = [
		Coordinates.new(1,0),
	]
	self.priority = 2
	self.rotate(rotation)
