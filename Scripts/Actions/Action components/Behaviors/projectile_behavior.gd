extends DefaultMoveBehavior
class_name ProjectileBehavior

var ram_damage = 1

func collide(other: BoardEntity = null) -> Array[BaseEvent]: ## to-do: make colliding entities able to interact
	var events : Array[BaseEvent] = []
	events.append_array(self.die())
	events.append(other.hit_direct(ram_damage))
	return events

func junction_collide(other: BoardEntity = null) -> Array[BaseEvent]:
	var events : Array[BaseEvent] = []
	events.append_array(self.die())
	events.append(other.hit_direct(ram_damage))
	return events

func hit_board_border() -> Array[BaseEvent]:
	return self.die()
