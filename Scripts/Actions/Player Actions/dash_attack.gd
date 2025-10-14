extends BaseAction
class_name DashAttack

func perform_action(character : CharacterController, entity : BoardEntity, direction:int = 0):
	entity.set_attack( QuickStabAttack.new(direction))
	entity.moves = [ Move.new(Coordinates.new(1,0)) ]
	entity.rotate_moves(direction)
	entity.behavior = DefaultAttackBehavior.new(entity)


func _init() -> void:
	self.action_name = "Dash_Attack"
