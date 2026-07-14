class_name BehaviourFactory

static func get_behaviour(behaviour_name : String, entity : BoardEntity) -> BaseEntityBehaviour:
	if behaviour_name == EntityBehaviours.DEFAULT_MOVE_BEHAVIOUR:
		return DefaultMoveBehavior.new(entity)
	if behaviour_name == EntityBehaviours.DEFAULT_ATTACK_BEHAVIOUR:
		return DefaultAttackBehavior.new(entity)
	if behaviour_name == EntityBehaviours.DEFAULT_IDLE_BEHAVIOUR:
		return DefaultIdleBehavior.new(entity)
	if behaviour_name == EntityBehaviours.PROJECTILE_BEHAVIOUR:
		return ProjectileBehavior.new(entity)
	if behaviour_name == EntityBehaviours.RAM_BEHAVIOUR:
		return RamBehavior.new(entity)
	return null
