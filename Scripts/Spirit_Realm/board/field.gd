class_name Field extends BoardElement

var x : int
var y : int

func get_debug_display() -> String:
	if len(entities) + len(attack_markers) == 0: return "_"
	else: if len(entities) + len(attack_markers) > 1: return "!"
	else: if len(entities)>0: return entities[0].debug_display
	else: return attack_markers[0].debug_display

	
