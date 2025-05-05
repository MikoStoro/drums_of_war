class_name DashAction
extends BaseAction

func perform_action(character : Character, entity : BoardEntity, rotation: int = 0):
	entity.attack = null
	entity.moves = [ Move.new(Coordinates.new(1,0)), Move.new(Coordinates.new(1,0)) ]
	entity.rotate_moves(character.get_direction())
	entity.behavior = DefaultMoveBehavior.new(entity)


func _init() -> void:
	self.action_name = "Dash"
