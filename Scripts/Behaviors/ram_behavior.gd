extends DefaultMoveBehavior
class_name RamBehavior

var ram_damage = 1

func collide(other: BoardEntity = null) -> Array[BoardEvent]: ## to-do: make colliding entities able to interact
	return other.hit_direct(ram_damage)

func junction_collide(other: BoardEntity = null) -> Array[BoardEvent]:
	return other.hit_direct(ram_damage)
