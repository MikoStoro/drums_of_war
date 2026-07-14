class_name ShortDashAction
extends BaseAction

func _init() -> void:
	self.action_name = "Short Dash"
	self.moves = [ Move.fwd() ]
	self.behaviour = EntityBehaviours.DEFAULT_MOVE_BEHAVIOUR
