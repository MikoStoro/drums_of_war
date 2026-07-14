extends Attack
class_name ThrustAttack

func _init(rotation:int = 0) -> void:
	self.name = "Thrust"
	target_blueprint = [
		Coordinates.new(1,0),
		Coordinates.new(1,0)
	]
	self.rotate(rotation)
