class_name Field extends BoardElement


func x() -> int:
	return self.location.x

func y() -> int:
	return self.location.y

func get_debug_display() -> String:
	if len(entities) + len(attack_markers) == 0: return "_"
	else: if len(entities) + len(attack_markers) > 1: return "!"
	else: if len(entities)>0: return entities[0].debug_display
	else: return attack_markers[0].debug_display

func _init(x: int, y: int) -> void:
	self.location = Coordinates.new(x,y)

	
