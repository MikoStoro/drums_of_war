class_name EntityBehavior

var e : BoardEntity

func turn_setup():
	e.knockback_immunity = false
	e.correction_required = false
func collide(other: BoardEntity = null): ## to-do: make colliding entities able to interact
	pass
func junction_collide(other: BoardEntity = null):
	pass
func stop():
	e.moves = []
	e.knockback_immunity = true
func hit(attack: Attack):
	print(e.debug_display + " has been hit!")
func _init(entity: BoardEntity) -> void:
	self.e = entity
