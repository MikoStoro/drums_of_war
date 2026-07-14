extends BaseAttackAction
class_name SlowDashAttack

func _init() -> void:
	self.action_name = "Slow Dash Attack"
	self.moves = [ Move.fwd() ]
	self.behaviour = EntityBehaviours.DEFAULT_ATTACK_BEHAVIOUR
	self.attack = Attacks.SLOW_STAB
