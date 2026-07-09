extends Node
class_name BackendClock

signal beat
signal board_update

@export var clock : Timer
@export var window_size = 0.5 #TODO - window can be larger before beat than after the beat
var beat_time : float

var input_window_flag : bool = false

func _ready() -> void:
	beat_time = clock.wait_time
	clock.timeout.connect(beat_event)

func in_input_window() -> bool:
	return clock.time_left <= beat_time * (window_size/2) || beat_time - clock.time_left <= beat_time * (window_size/2)

func beat_event():
	beat.emit()

func _process(delta: float) -> void:
	if in_input_window() && input_window_flag == false:
		input_window_flag = true

	## board is updated at the end of input window (so even the late inputs are counted)
	if !in_input_window() && input_window_flag == true:
		input_window_flag = false
		board_update.emit()
