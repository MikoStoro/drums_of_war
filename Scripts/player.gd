extends Node

@export var player_id: int = 1
var queued_action: BaseAction

func _process(delta: float) -> void:
	queued_action = _check_for_action()


## activated with signal from timer
func execute_action() -> void:
	if queued_action:
		queued_action.perform_action(self)
			
func _check_for_action() -> BaseAction:
	if Input.is_action_just_pressed("player"+str(player_id)+"_move_left"):
		print("move")		
		return MoveRight.new()
	else:
		return null
