extends BaseAction
class_name DefaultIdleAction

func perform_action(character : CharacterController, entity : BoardEntity, direction:int = 0):
	entity.reset_attack()
	entity.moves = [ ]
	entity.behavior = DefaultIdleBehavior.new(entity)


func _init() -> void:
	self.action_name = "Idle"
