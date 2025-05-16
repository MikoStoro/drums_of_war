extends Node
class_name Direction_Tools

static func get_direction_index(direction_vector: Vector2) -> int: 
	
	var steps = -1 * direction_vector.angle_to(Vector2.DOWN)/PI*4
	#print(steps)
	if steps < 0: 
		steps *= -1
	else:
		steps = 8 - steps
	#print(steps)
	var steps2 = int(round(steps))
	#print(steps2)
	return steps2
	
static func get_direction_angle_v(direction_vector: Vector2) -> float:
	return floor(get_direction_index(direction_vector)) * PI/4

static func get_direction_angle_i(direction_index : int ) -> float:
	return direction_index * PI/4
