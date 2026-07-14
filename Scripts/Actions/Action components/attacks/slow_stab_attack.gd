extends Attack
class_name SlowStabAttack

func _init(rotation:int = 0) -> void:
	self.name = "Slow Stab"
	self.priority = 2
	self.damage = 2
	target_blueprint = [
		Coordinates.new(1,0),
	]
	self.rotate(rotation)
