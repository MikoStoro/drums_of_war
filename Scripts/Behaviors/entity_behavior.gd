class_name EntityBehavior

var e : BoardEntity

func turn_setup():
	e.knockback_immunity = false
	e.correction_required = false
func collide(other: BoardEntity = null) -> BoardEvent:
	return null
func junction_collide(other: BoardEntity = null) -> BoardEvent:
	return null
func stop():
	e.moves = []
	e.knockback_immunity = true
func hit(attack: Attack) -> AttackResult:
	self.take_damage(attack.damage)
	print(e.debug_display + " has been hit for " + str(attack.damage) + " damage!")
	return AttackResult.new(attack.damage)
func hit_direct(damage: int) -> AttackResult:
	self.take_damage(damage)
	print(e.debug_display + " has been hit for " + str(damage) + " damage!")
	return AttackResult.new(damage)
func _init(entity: BoardEntity) -> void:
	self.e = entity
func take_damage(amount : int):
	e.health -= amount
	if e.health <= 0:
		self.die()
func heal(amount: int):
	e.health += amount
func die():
	print(e.debug_display + " has died!")
