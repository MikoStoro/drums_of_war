class_name EntityBehavior

var e : BoardEntity

func turn_setup():
	pass

func collide(other: BoardEntity = null) -> Array[BoardEvent]:
	return []
func junction_collide(other: BoardEntity = null) -> Array[BoardEvent]:
	return []
func stop():
	e.moves = []

func hit(attack: Attack) -> Array[BoardEvent]:
	return self.hit_direct(attack.damage)

func hit_direct(damage: int) -> Array[BoardEvent]:
	print(e.debug_display + " has been hit for " + str(damage) + " damage!")
	return self.take_damage(damage)

func _init(entity: BoardEntity) -> void:
	self.e = entity

func take_damage(amount : int) -> Array[BoardEvent]:
	self.stagger()
	var events : Array[BoardEvent] = []
	e.health -= amount
	var event = BoardEvent.new(GlobalEnums.event_type.HIT, e, [e.coordinates.get_vector2()])
	event.add_data(HitResult.new(amount))
	events.append(event)
	if e.health <= 0:
		self.die()
		events.append(BoardEvent.new(GlobalEnums.event_type.DEATH, e, [e.coordinates.get_vector2()]))
	return events
func stagger():
	e.attack = null
	e.summon = {}
	##TODO some message?
func heal(amount: int):
	e.health += amount
func die():
	e.death()
