class_name RamAction
extends BaseAction

func perform_action(character : CharacterController, entity : BoardEntity,  direction:int = 0):
	entity.attack = null
	entity.moves = [ Move.new(Coordinates.new(1,0))]
	entity.rotate_moves(direction)
	entity.behavior = RamBehavior.new(entity)

func _init() -> void:
	self.action_name = "Short Dash"
