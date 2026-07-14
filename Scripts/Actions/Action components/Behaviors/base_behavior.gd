class_name EntityBehavior

var e : BoardEntity

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

func _init(entity: BoardEntity) -> void:
	self.e = entity

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

func stagger():
	e.attack = null
	e.summon = {}
	##TODO some message?
func heal(amount: int):
	e.health += amount
func die():
	e.death()
func hit_board_border():
	pass
