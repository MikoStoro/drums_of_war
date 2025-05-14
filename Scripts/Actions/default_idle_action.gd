extends BaseAction
class_name DefaultIdleAction

func perform_action(character : CharacterController, entity : BoardEntity):
	entity.reset_attack()
	entity.moves = [ ]
	entity.behavior = DefaultIdleBehavior.new(entity)


func _init() -> void:
	self.action_name = "Idle"
