extends BaseAction
class_name DashAttack

func perform_action(character : CharacterController, entity : BoardEntity):
	var direction = character.get_direction()
	entity.attack = StabAttack.new(direction)
	entity.moves = [ Move.new(Coordinates.new(1,0)) ]
	entity.rotate_moves(direction)
	entity.behavior = DefaultMoveBehavior.new(entity)


func _init() -> void:
	self.action_name = "Dash_Attack"
