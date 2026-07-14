extends BaseAttackAction
class_name DashAttack

func _init() -> void:
	self.action_name = "Dash_Attack"
	self.moves = [ Move.fwd() ]
	self.behaviour = EntityBehaviours.DEFAULT_ATTACK_BEHAVIOUR
	self.attack = Attacks.QUICK_STAB
	
