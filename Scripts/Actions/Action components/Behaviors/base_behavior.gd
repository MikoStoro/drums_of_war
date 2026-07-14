class_name BaseEntityBehaviour

var e : BoardEntity

func _init(entity: BoardEntity) -> void:
	self.e = entity

func turn_setup():
	pass

func collide(other: BoardEntity = null) -> Array[BaseEvent]:
	return []

func junction_collide(other: BoardEntity = null) -> Array[BaseEvent]:
	return []

func stop():
	e.moves = []

func hit(attack: Attack) -> Array[BaseEvent]:
	return self.hit_direct(attack.damage)

func hit_direct(damage: int) -> Array[BaseEvent]:
	print(e.debug_display + " has been hit for " + str(damage) + " damage!")
	return self.take_damage(damage)

func take_damage(amount : int) -> Array[BaseEvent]:
	self.stagger()
	var events : Array[BaseEvent] = []
	e.health -= amount
	var event = EntityEvent.new(EventTypes.HIT, e.character_id, [e.coordinates.get_vector2()])
	event.add_data(HitResult.new(amount))
	events.append(event)
	if e.health <= 0:
		self.die()
		events.append(EntityEvent.new(EventTypes.DEATH, e.character_id, [e.coordinates.get_vector2()]))
	return events

func stagger() -> Array[BaseEvent]:
	e.attack = null
	e.summon = {}
	return [ EntityEvent.new(EventTypes.STAGGER, e.character_id, [e.coordinates.get_vector2()]) ]

func heal(amount: int) -> Array[BaseEvent]:
	e.health += amount
	return [ EntityEvent.new(EventTypes.HEAL, e.character_id, [e.coordinates.get_vector2()]) ]

func die() -> Array[BaseEvent]:
	e.death()
	return [ EntityEvent.new(EventTypes.DEATH, e.character_id, [e.coordinates.get_vector2()]) ]

func hit_board_border() -> Array[BaseEvent]:
	return []
