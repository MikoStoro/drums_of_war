extends BaseAction
class_name QuickStabAction

func perform_action(character : CharacterController, entity : BoardEntity,  direction:int = 0):
	entity.set_attack(QuickStabAttack.new(direction))
	entity.moves = [  ]
	entity.behavior = DefaultAttackBehavior.new(entity)


func _init() -> void:
	self.action_name = "Stab"
