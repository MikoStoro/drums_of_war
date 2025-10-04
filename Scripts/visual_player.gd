extends Node2D
class_name VisualCharacter

#@export var animation: AnimationPlayer
#@export var animation_sprite: AnimatedSprite2D
@export var player_animations: AnimatedSprite2D
@export var sprite: Sprite2D
@export var hpbar: ProgressBar
#@export var line_texture: Texture
# set this somewhere else (maybe when creating player)
var deadzone := 0.2
var is_keyboard := true
var tile_size : float = VisualBoardTools.tile_size
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}

func new_orders(arr: Array[BoardEvent]) -> void:
	for event: BoardEvent in arr:
		event = _adapt_event_to_visual_realm(event)
		
		match event.type:
			GlobalEnums.event_type.MOVE:
				_move(event.place[0])	#Move always should have only one element, so its function takes only one
			GlobalEnums.event_type.ATTACK:
				_draw_line(event.place, event)
			GlobalEnums.event_type.HIT:
				_recieve_hit()

func _recieve_hit() -> void:
	print("WAAAAGH")
	sprite.modulate = Color(1,1,1) #doesnt work on black...
	hpbar.value -=1
	
func _adapt_event_to_visual_realm(event: BoardEvent) -> BoardEvent:
		var newArr: Array[Vector2] = []
		for e in event.place:
			var v := VisualBoardTools.spirit_tile_into_visual(Vector2(e.x,e.y))
			newArr.append(v)
		var newEvent = BoardEvent.new(event.type, event.object, newArr)
		return newEvent

func _draw_line(arr: Array[Vector2], event: BoardEvent):
	
	#same animation name as attack so you can get it straigth from Event
	#print(event)
	#print(event.Object)
	print(event.object.name)
	player_animations.play(event.object.name)
	
	
	var line := Line2D.new()
	get_tree().root.add_child(line) # add it to root so it doesnt move with player
	line.width = 5
	#line.default_color = Color.CRIMSON
	#line.texture = line_texture
	line.default_color = Color(1, 1, 1, 0.1)
	line.texture_mode = line.LINE_TEXTURE_TILE	
	for pos in arr:
		line.add_point(pos)
	await get_tree().create_timer(0.2).timeout
	line.queue_free()
		
#func play_animation(name: String) -> void:
	## not sure how to properly corelate speed in code with animation player
	#animation.speed_scale = 10
	#animation.play(name)
	
	
func _move(coords: Vector2) -> void:
	#play_animation("move") # ie wind
	#coords = Vector2(coords.y,coords.x) 
	var new_position = coords
	var tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.05) 

var _last_known_vector:= Vector2.ZERO
func _get_joystick_direction(device := 0):
	var x = Input.get_joy_axis(device, JOY_AXIS_LEFT_X)
	var y = Input.get_joy_axis(device, JOY_AXIS_LEFT_Y)
	var dir = Vector2(x,y)
	if dir.length() < deadzone:
		return _last_known_vector
	_last_known_vector = dir
	return dir
	
func _get_direction():
	if is_keyboard:
		return get_relative_mouse_position()		
	return _get_joystick_direction()

## by MikoStoro
func get_relative_mouse_position():
	return get_global_mouse_position() - position

func apply_visual_effect(color):
	$CharacterSprite.modulate = color

var direction : int = 0
@onready var base_rotation : int = self.rotation
@onready var rotation_tween = create_tween()
func _process(delta) -> void:
	var new_direction = Direction_Tools.get_direction_index(_get_direction().normalized())
	if new_direction != direction:
		rotate_to_direction(new_direction)
		self.direction = new_direction

func get_current_direction() -> int:
	return Direction_Tools.get_direction_index(_get_direction().normalized())

func rotate_to_direction(new_direction : int = 0):
	var rotation_value = -Direction_Tools.get_direction_angle_i(new_direction) + self.base_rotation
	rotation_value = lerp_angle(rotation, rotation_value, 1)
	var t = create_tween()
	t.tween_property(self, "rotation", rotation_value, 0.075)
	#$DirectionIndicator.rotate_to_direction(new_direction)

func _ready():
	pass

	
