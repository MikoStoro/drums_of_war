class_name Junction
extends BoardElement

func process_collisions():
	if len(entities) > 1:
		for e in entities: e.junction_collide()
	return _get_collision_events()


func process_clashes(): 
	if len(attack_markers) > 1:
		for a in attack_markers:
			a.junction_clash()
	return _get_clash_events()

func clear():
	entities = []

func _init(f1: Coordinates, f2: Coordinates) -> void:
	location = Coordinates.new((f1.x + f2.x)/2, (f1.y + f2.y)/2)
