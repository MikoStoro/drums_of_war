class_name EntityBehavior

var e : BoardEntity

func turn_setup():
	pass
func collide():
	pass
func junction_collide():
	pass
	
func _init(entity: BoardEntity) -> void:
	self.e = entity
