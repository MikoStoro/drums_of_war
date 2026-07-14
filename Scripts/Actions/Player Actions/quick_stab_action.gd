extends BaseAttackAction
class_name QuickStabAction

func _init() -> void:
	self.action_name = "Stab"
	self.behaviour = EntityBehaviours.DEFAULT_ATTACK_BEHAVIOUR
	self.attack = Attacks.QUICK_STAB
