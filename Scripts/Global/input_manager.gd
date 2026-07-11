extends Node

## { device_id : player_id }
var device_to_player: Dictionary[int, int] = {}

## { device_id : player_id }
var player_to_device: Dictionary = {}

## { player_id : action }
var input_buffer: Dictionary[int, GlobalEnums] = {}

## { player_id : Vector2 }
var _last_known_vectors: Dictionary = {}

var deadzone: float = 0.2
var action_number: int = 0

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


func get_aim_direction(player_id: int) -> Vector2:
	# -2 as error since by default M&K is -1
	var device_id = player_to_device.get(player_id, -2)
	
	if device_id == -1:
		var entity = GameEntityManager.get_entity(player_id)
		var mouse_pos = entity.get_global_mouse_position()
		return (mouse_pos - entity.global_position).normalized()
		
	elif device_id >= 0:
		var x = Input.get_joy_axis(device_id, JOY_AXIS_LEFT_X)
		var y = Input.get_joy_axis(device_id, JOY_AXIS_LEFT_Y)
		var dir = Vector2(x, y)
		
		if dir.length() < deadzone:
			return _last_known_vectors.get(player_id, Vector2.RIGHT)
			
		dir = dir.normalized()
		_last_known_vectors[player_id] = dir
		return dir
		
	return Vector2.ZERO
	
	
	
func send_input_to_backend() -> void:
	if input_buffer.is_empty():
		return
		
	# Sending to backend (or to frontend_messenger.gd to keep single point of contact)
	for input in input_buffer:
		var dir = get_aim_direction(input)
		pass
	#numer wywołanej akcji
	#referencję do tego, który to gracz # devicetoplayer
	#kierunek w którym gracz celował
	#moment w cyklu bębna, w którym nastąpił input # I guess ilość ms od perfect hit?
		
	input_buffer.clear()
