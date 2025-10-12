extends DefaultMoveBehavior
class_name ProjectileBehavior

var ram_damage = 1

func collide(other: BoardEntity = null) -> Array[BoardEvent]: ## to-do: make colliding entities able to interact
	self.e.death()
	return other.hit_direct(ram_damage)

func junction_collide(other: BoardEntity = null) -> Array[BoardEvent]:
	self.e.death()
	return other.hit_direct(ram_damage)
