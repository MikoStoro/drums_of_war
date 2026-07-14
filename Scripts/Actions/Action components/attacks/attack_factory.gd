class_name AttackFactory

static func get_attack(attack_name : String, direction : int) -> Attack:
	if behaviour_name == Attacks.CLEAVE:
		return CleaveAttack.new(direction)
	if behaviour_name == Attacks.QUICK_STAB:
		return QuickStabAttack.new(direction)
	if behaviour_name == Attacks.SLOW_STAB:
		return SlowStabAttack.new(direction)
	if behaviour_name == Attacks.STAB:
		return StabAttack.new(direction)
	if behaviour_name == Attacks.THRUST:
		return ThrustAttack.new(direction)
	return null
