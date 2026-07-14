extends BaseEntityBehaviour
class_name DefaultIdleBehavior

func turn_setup():
	pass

func collide(other: BoardEntity = null): ## to-do: make colliding entities able to interact
	return []
	
func junction_collide(other: BoardEntity = null):
	return []
	
