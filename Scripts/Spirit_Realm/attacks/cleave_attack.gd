extends Attack
class_name CleaveAttack

func _init(rotation:int = 0) -> void:
	target_blueprint = [
		Coordinates.new(1,-1),
		Coordinates.new(1,0),
		Coordinates.new(1,1)
	]
	self.rotate(rotation)
