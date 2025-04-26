extends Attack
class_name ThrustAttack

func _init(rotation:int = 0) -> void:
	self.name = "thrust"
	target_blueprint = [
		Coordinates.new(1,0),
		Coordinates.new(1,0)
	]
	self.rotate(rotation)
