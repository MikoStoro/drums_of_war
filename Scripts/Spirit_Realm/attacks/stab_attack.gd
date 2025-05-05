extends Attack
class_name StabAttack

func _init(rotation:int = 0) -> void:
	self.name = "Stab"
	target_blueprint = [
		Coordinates.new(1,0),
	]
	self.priority = 3
	self.rotate(rotation)
