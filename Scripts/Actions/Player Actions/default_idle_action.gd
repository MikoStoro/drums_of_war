extends BaseAction
class_name DefaultIdleAction

func _init() -> void:
	self.action_name = "Idle"
	self.behaviour = EntityBehaviours.DEFAULT_IDLE_BEHAVIOUR
