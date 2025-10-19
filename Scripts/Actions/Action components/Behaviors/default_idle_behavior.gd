extends EntityBehavior
class_name DefaultIdleBehavior

func turn_setup():
	pass
	#e.knockback_immunity = true
	#e.correction_required = false
func collide(other: BoardEntity = null): ## to-do: make colliding entities able to interact
	pass
func junction_collide(other: BoardEntity = null):
	pass
