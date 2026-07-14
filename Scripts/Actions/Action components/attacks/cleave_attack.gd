extends Attack
class_name CleaveAttack

func _init(rotation:int = 0) -> void:
	self.name = "Cleave"
	target_blueprint = [
		Coordinates.new(1,1),
		Coordinates.new(0,-1),
		Coordinates.new(0,-1)
	]
	self.rotate(rotation)
