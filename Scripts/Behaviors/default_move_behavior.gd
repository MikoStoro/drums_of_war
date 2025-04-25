class_name DefaultMoveBehavior
extends EntityBehavior

func collide(): ## to-do: make colliding entities able to interact
	if not e.knockback_immunity:
		e.moves = [Move.new(e.get_last_move().direction.invert())]
func junction_collide():
	var current_move = e.get_current_move()
	e.moves = [Move.new(e.get_last_move().direction.invert(),true)] 
	e.knockback_immunity = true
	e.correction_required = true
