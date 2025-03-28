extends BaseAction


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_name = "Move To Mouse"
	SPEED = 200
	
func perform_action(character):
	var direction = character.get_relative_mouse_position().normalized()
	print(direction)
	character.velocity.x = direction.x * SPEED
	character.velocity.y = direction.y * SPEED

func end_action(character):
	character.velocity.x = 0
	character.velocity.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
