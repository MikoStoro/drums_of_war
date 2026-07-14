class_name RamAction
extends BaseAction

func _init() -> void:
	self.action_name = "Short Dash"
	self.behaviour = EntityBehaviours.RAM_BEHAVIOUR
	self.moves = [ Move.fwd() ]
	
