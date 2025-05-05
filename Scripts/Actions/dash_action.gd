class_name DashAction
extends BaseAction

func perform_action(character : Character, entity : BoardEntity):
	entity.attack = null
	entity.moves = [ Move.new(Coordinates.new(1,0)), Move.new(Coordinates.new(1,0)) ]
	var direction = character.get_direction()
	entity.rotate_moves(direction)
	entity.behavior = DefaultMoveBehavior.new(entity)


func _init() -> void:
	self.action_name = "Dash"
