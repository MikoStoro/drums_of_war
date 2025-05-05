class_name ThrustAction
extends BaseAction

# Called when the node enters the scene tree for the first time.
func perform_action(character : Character, entity : BoardEntity):
	var direction = character.get_direction()
	entity.set_attack(ThrustAttack.new(direction))
	entity.moves = [ ]
	entity.behavior = DefaultMoveBehavior.new(entity)


func _init() -> void:
	self.action_name = "Thrust_attack"
