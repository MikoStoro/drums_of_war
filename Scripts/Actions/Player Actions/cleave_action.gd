class_name CleaveAction
extends BaseAttackAction

func _init() -> void:
	self.action_name = "Cleave_attack"
	self.attack = Attacks.CLEAVE
	self.behaviour = EntityBehaviours.DEFAULT_MOVE_BEHAVIOUR
