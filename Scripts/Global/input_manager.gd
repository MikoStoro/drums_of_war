extends Node


## { backend_player_id : action }
var input_buffer: Dictionary[int, GlobalEnums] = {}

func assign_controller(device_id: int, player_id: int) -> void:
	device_to_player[device_id] = player_id

func _input(event: InputEvent) -> void:
	var device = event.device # godot's input registers device ID
	
	# ignore unregistered input
	if not device_to_player.has(device):
		return
		
	var player_id = device_to_player[device]
	
	#if event.is_action_pressed(""):
		#input_buffer[player_id] = 
	
func send_input_to_backend() -> void:
	if input_buffer.is_empty():
		return
		
	# Sending to backend
	
	input_buffer.clear()
