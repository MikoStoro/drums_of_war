class_name CleaveAction
extends BaseAction

# Called when the node enters the scene tree for the first time.
func perform_action(character : CharacterController, entity : BoardEntity, direction:int = 0):
	entity.set_attack(CleaveAttack.new(direction))
	entity.moves = [ ]
	entity.behavior = DefaultMoveBehavior.new(entity)


func _init() -> void:
	self.action_name = "Thrust_attack"
