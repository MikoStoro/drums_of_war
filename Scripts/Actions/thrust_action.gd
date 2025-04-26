class_name ThrustAction
extends BaseAction

# Called when the node enters the scene tree for the first time.
func perform_action(character : Character, entity : BoardEntity, direction: int = 0):
	entity.attack = ThrustAttack.new(direction)
	entity.moves = [ ]
	entity.behavior = DefaultMoveBehavior.new(entity)


func _init() -> void:
	self.action_name = "Thrust_attack"
