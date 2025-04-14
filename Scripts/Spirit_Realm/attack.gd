class_name Attack

var priority : int = 1
var damage : int = 1
var targets : Array[Coordinates] = [] # an array of coordinates
var current_target : int = 0

func count_remaining_targets():
	return len(targets) - current_target

func get_current_target():
	return targets[current_target]

func pop_target() -> Coordinates:
	current_target += 1
	return targets[current_target-1]

func clash(): ##used when attack hits another attack
	pass

func collide(): ##used when attack hits entity
	pass
