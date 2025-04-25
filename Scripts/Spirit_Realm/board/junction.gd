class_name Junction
extends BoardElement

func perform_clash(a1: Attack, a2: Attack):
	a1.junction_clash(a2)

func perform_collide(e1: BoardEntity, e2: BoardEntity):
	e1.junction_collide(e2)

func clear():
	entities = []

func _init(f1: Coordinates, f2: Coordinates) -> void:
	location = Coordinates.new((f1.x + f2.x)/2, (f1.y + f2.y)/2)
