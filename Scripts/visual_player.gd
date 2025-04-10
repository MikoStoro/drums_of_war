extends Node2D

@export var animation: AnimationPlayer
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

func play_animation(name: String) -> void:
	# not sure how to properly corelate speed in code with animation player
	animation.speed_scale = 5
	animation.play(name)
	
func _move(dir: Vector2, distance) -> void:
	# TODO play animation
	play_animation("move")
	var new_position = position + dir * tile_size * distance
	
	var tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.2) 
	
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			_move(inputs[dir], 2)
	
	
