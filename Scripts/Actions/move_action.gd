extends BaseAction
class_name MoveRight
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_name = "Move Right"
	SPEED = 400

func perform_action(character, entity):
	character.dir = 1
	character.velocity.x = character.dir * SPEED

func end_action(character):
	character.velocity.x = 0
