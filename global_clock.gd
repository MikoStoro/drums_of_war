extends Node

signal beat
signal input_window_enter
signal input_window_leave

var clock
@export var beat_time : float
var input_window_flag : bool = false

const window_size = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock = $MainBeat
	beat_time = clock.wait_time
	clock.timeout.connect(beat_event)
	
func in_input_window() -> bool:
	return clock.time_left <= beat_time * (window_size/2) || beat_time - clock.time_left <= beat_time * (window_size/2)

func beat_event():
	beat.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_input_window() && input_window_flag == false:
		input_window_flag = true
		input_window_enter.emit()
		
	if !in_input_window() && input_window_flag == true:
		input_window_flag = false
		input_window_leave.emit()
