class_name BoardElement

var entities : Array[BoardEntity] = []
var attack_markers : Array[Attack] = []

func process_clashes():
	if len(attack_markers) > 1:
		for a in attack_markers:
			a.clash()
			
func process_hits():
	if len(entities)>0 and len(attack_markers) > 0:
		for a in attack_markers:
			for e in entities:
				e.hit(a)
			
func count_entities():
	return len(entities)

func count_attack_markers():
	return len(attack_markers)
