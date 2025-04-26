class_name Attack

var priority : int = 2 #from 1 (fast) to 3 (slow)
var damage : int = 1
var targets : Array[Coordinates] = [] # an array of coordinates
var target_blueprint : Array[Coordinates] = []
var user_coordinates : Coordinates = null
var current_target : int = 0
var finished = false
var correction_required = false
var debug_display = 'o'
var name : String = "attack_name"

func count_remaining_targets() -> int:
	var remaining = len(targets) - current_target
	return remaining

func get_current_target() -> Coordinates:
	return targets[current_target]

func get_last_target() -> Coordinates:
	if current_target == 0: return user_coordinates
	return targets[current_target-1]

func pop_target() -> Coordinates:
	current_target += 1
	return get_last_target()

func is_finished() -> bool:
	if finished: return true
	else: if count_remaining_targets() < 1: return true
	else: return false

func junction_clash(other: Attack = null): ##used when attack hits another attack between fields
	finished = true
	correction_required = true
	
func clash(other : Attack = null): ##used when attack hits another attack
	finished = true

func collide(): ##used when attack hits entity
	pass

func rotate(steps:int):
	for c in target_blueprint:
		c.rotate(steps)

func apply_blueprint(entity):
	user_coordinates = entity.coordinates
	var last_coordinates = user_coordinates
	for b in target_blueprint:
		last_coordinates = last_coordinates.add(b)
		targets.append(last_coordinates)

func _to_string():
	return debug_display
	
		
	
