extends DefaultMoveBehavior
class_name RamBehavior

var ram_damage = 1

func collide(other: BoardEntity = null) -> BoardEvent: ## to-do: make colliding entities able to interact
	var event = BoardEvent.new(GlobalEnums.event_type.HIT, [other, null], [other.coordinates.get_vector2()])
	event.add_data(other.hit_direct(ram_damage))
	return event
func junction_collide(other: BoardEntity = null) -> BoardEvent:
	var event = BoardEvent.new(GlobalEnums.event_type.HIT, [other,null], [other.coordinates.get_vector2()])
	event.add_data(other.hit_direct(ram_damage))
	return event
