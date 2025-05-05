extends Node2D

@export var animation: AnimationPlayer
@export var animation_sprite: AnimatedSprite2D
# set this somewhere else (maybe when creating player)
var tile_size = 16
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}
			
		
func new_orders(arr: Array[BoardEvent]) -> void:
	for event: BoardEvent in arr:
		if event.type == GlobalEnums.event_type.MOVE:
			move(event.place)

func _process(delta: float) -> void:
	pass

	# if I understand correctly, AnimationPlayer for using keyframes 
	# and AnimationSprite for spritesheets
	
func _draw_line(arr: Array[Vector2]):
	draw_polyline(arr, Color.REBECCA_PURPLE)

func attack():
	animation_sprite.play("attack")
	var array = PackedVector2Array([Vector2(12, 34), Vector2(56, 78)])
	_draw_line(array)

func play_animation(name: String) -> void:
	# not sure how to properly corelate speed in code with animation player
	animation.speed_scale = 5
	animation.play(name)
	
	
func move(coords: Vector2) -> void:
	play_animation("move")
	coords = Vector2(coords.y,coords.x) 
	var new_position = coords * tile_size
	var tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.2) 
	
	
#func _unhandled_input(event):
	#for dir in inputs.keys():
		#if event.is_action_pressed(dir):
			#move(Vector2(3,2))
	#if event.is_action_pressed("player1_action1"):
			#move(Vector2(2,1))
			#attack()
	
	
