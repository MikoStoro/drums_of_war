class_name ProjectileAction
extends BaseAction
## This action is performed BY A SPELL ENTITY

func _init() -> void:
	self.action_name = "Projectile Action"
	self.moves = [ Move.fwd() ]
	self.behaviour = EntityBehaviours.PROJECTILE_BEHAVIOUR
