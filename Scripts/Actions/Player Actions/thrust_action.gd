class_name ThrustAction
extends BaseAttackAction

func _init() -> void:
	self.action_name = "Thrust_attack"
	self.behaviour = EntityBehaviours.DEFAULT_MOVE_BEHAVIOUR
	self.attack = Attacks.THRUST
