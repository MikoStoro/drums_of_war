class_name DashAction
extends BaseAction

func _init() -> void:
	self.action_name = "Dash"
	self.moves = [ Move.fwd(), Move.fwd() ]
	self.behaviour = EntityBehaviours.DEFAULT_MOVE_BEHAVIOUR
