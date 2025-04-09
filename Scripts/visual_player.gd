extends Node2D

# set this somewhere else (maybe when creating player)
var tile_size = 128
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _process(delta: float) -> void:
	pass
	#_move(inputs['down'])
	#_move(inputs['right'])
	#_move(inputs['up'])
	#_move(inputs['left'])

func _move(dir: Vector2, distance) -> void:
	# TODO play animation
	global_position += dir * tile_size * distance
	
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			_move(inputs[dir], 2)
	
	
