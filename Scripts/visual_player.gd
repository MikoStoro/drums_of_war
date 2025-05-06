extends Node2D

@export var animation: AnimationPlayer
@export var animation_sprite: AnimatedSprite2D
# set this somewhere else (maybe when creating player)
var tile_size = 16
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}
			
var debug_points=PackedVector2Array([
	Vector2(0,0),
	Vector2(1000,1000),
	Vector2(100,000)
])
		
func new_orders(arr: Array[BoardEvent]) -> void:
	for event: BoardEvent in arr:
		if event.type == GlobalEnums.event_type.MOVE:
			move(event.place)
		if event.type == GlobalEnums.event_type.ATTACK:
			_draw_line(PackedVector2Array([event.place * tile_size, position * tile_size]))

func _process(delta: float) -> void:
	pass

	# if I understand correctly, AnimationPlayer for using keyframes 
	# and AnimationSprite for spritesheets
func float_array_to_Vector2Array(coords : Array) -> PackedVector2Array:
	# Convert the array of floats into a PackedVector2Array.
	var array : PackedVector2Array = []
	for coord in coords:
		array.append(Vector2(coord[0], coord[1]))
	return array
	
func _draw_line(arr: PackedVector2Array):
	#queue_redraw()
	var line := Line2D.new()
	add_child(line)
	line.add_point(position)
	line.add_point(Vector2(100,100)) 
	line.remove_point(0)
	#draw_colored_polygon(debug_points, Color.RED)
	#
#func _draw():
	#if Input.is_action_pressed("ui_down"):
		#draw_colored_polygon(debug_points, Color.RED)
		
func attack(arr: Array[Vector2]):
	animation_sprite.play("attack")
	#var array = PackedVector2Array([Vector2(12, 34), Vector2(56, 78)])
	_draw_line(float_array_to_Vector2Array(arr))
	#_draw_line(100,100)

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
	
	
