extends Node2D

@export var animation: AnimationPlayer
@export var animation_sprite: AnimatedSprite2D
# set this somewhere else (maybe when creating player)
var tile_size := 16.0
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}
		
func new_orders(arr: Array[BoardEvent]) -> void:
	for event: BoardEvent in arr:
		var newArr: Array[Vector2] = []
		for e in event.place:
			var v := Vector2(e.y * tile_size - tile_size/2, e.x * tile_size - tile_size/2)
			newArr.append(v)
		event.place = newArr
		
		if event.type == GlobalEnums.event_type.MOVE:
			move(event.place[0])
		if event.type == GlobalEnums.event_type.ATTACK:
			_draw_line(event.place)

func _draw_line(arr: Array[Vector2]):
	var line := Line2D.new()
	get_tree().root.add_child(line)
	line.width = 3
	line.default_color = Color.CRIMSON
	
	for pos in arr:
		line.add_point(pos)
		
	await get_tree().create_timer(1.0).timeout
	line.queue_free()
		
func play_animation(name: String) -> void:
	# not sure how to properly corelate speed in code with animation player
	animation.speed_scale = 5
	animation.play(name)
	
	
func move(coords: Vector2) -> void:
	play_animation("move")
	#coords = Vector2(coords.y,coords.x) 
	var new_position = coords
	var tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.2) 
	
	
	
	
