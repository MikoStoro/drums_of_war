class_name Junction

var entities : Array[BoardEntity] = []
var attack_markers : Array[Attack] = []

func process_collisions():
	if len(entities) > 1:
		for e in entities: e.junction_collide()

func process_clashes(): 
	if len(attack_markers) > 1:
		for a in attack_markers:
			a.junction_clash()
	
func clear():
	entities = []
