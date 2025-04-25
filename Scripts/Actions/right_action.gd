class_name RightAction
extends BaseAction

func perform_action(character : Character, entity : BoardEntity):
	entity.attack = null
	entity.moves = [ Move.new(Coordinates.new(0,1)) ]
	entity.behavior = DefaultMoveBehavior.new(entity)


func _init() -> void:
	self.action_name = "Move_Right"
