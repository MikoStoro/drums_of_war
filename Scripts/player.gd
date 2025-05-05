extends Node

@onready var clock = $"../GlobalClock"

@export var player_id: int = 1
var queued_action: BaseAction


func _ready() -> void:
	clock.beat.connect(_on_beat)
	clock.input_window_enter.connect(_input_window_enter)
	clock.input_window_leave.connect(_input_window_leave)

func _input_window_enter():
	pass
	
#to be overriden
func _input_window_leave():
	pass

func _on_beat():
	execute_action()

func _process(delta: float) -> void:
	# add ORDERED state so it doesnt overwrite action with null
	queued_action = _check_for_action()


## activated with signal from timer
func execute_action() -> void:
	if queued_action:
		queued_action.perform_action(self)
			
func _check_for_action() -> BaseAction:
	if Input.is_action_just_pressed("player"+str(player_id)+"_action1"):
		print("move")		
		return MoveRight.new()
	else:
		return null
