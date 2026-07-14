extends Attack
class_name StabAttack

func _init(rotation:int = 0) -> void:
	self.name = "Stab"
	self.priority = 1
	target_blueprint = [
		Coordinates.new(1,0),
	]
	self.rotate(rotation)
