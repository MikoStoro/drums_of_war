extends BaseAction

func perform_action(character : Character, entity : BoardEntity, rotation: int = 0):
	entity.attack = StabAttack.new(rotation)
	entity.moves = rotate_moves([ Move.new(Coordinates.new(1,0)) ], rotation)
	entity.behavior = DefaultMoveBehavior.new(entity)


func _init() -> void:
	self.action_name = "Dash_Attack"
