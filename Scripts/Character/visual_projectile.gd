extends Node2D
class_name VisualProjectile

#@export var animation: AnimationPlayer
#@export var animation_sprite: AnimatedSprite2D
@export var sprite: Sprite2D
#@export var line_texture: Texture
# set this somewhere else (maybe when creating player)
var is_keyboard := false

func new_orders(arr: Array[BoardEvent]) -> void:
	for event: BoardEvent in arr:
		event = _adapt_event_to_visual_realm(event)
		
		match event.type:
			GlobalEnums.event_type.MOVE:
				_move(event.place[0])	#Move always should have only one element, so its function takes only one
			GlobalEnums.event_type.COLLISION:
				$Sprite/CollisionSparks.emitting = true

func  _recieve_hit(dmg : int) -> void:
	pass

func _adapt_event_to_visual_realm(event: BoardEvent) -> BoardEvent:
		var newArr: Array[Vector2] = []
		for e in event.place:
			var v := VisualBoardTools.spirit_tile_into_visual(Vector2(e.x,e.y))
			newArr.append(v)
		var newEvent = BoardEvent.new(event.type, event.object, newArr)
		for d in event.extra_data:
			newEvent.add_data(d)
		return newEvent
	
func _move(coords: Vector2) -> void:
	#play_animation("move") # ie wind
	#coords = Vector2(coords.y,coords.x) 
	var new_position = coords
	var tween = create_tween()
	print(new_position)
	tween.tween_property(self, "position", new_position, 0.05) 

func get_current_direction():
	return self.direction

func set_direction(dir: int):
	self.direction = dir
	self.rotate_to_direction(self.direction)

func apply_visual_effect(color):
	$CharacterSprite.modulate = color

var direction : int = 0
func _process(delta) -> void:
	pass

func rotate_to_direction(new_direction : int = 0):
	var rotation_value = -Direction_Tools.get_direction_angle_i(new_direction) 
	#rotation_value = lerp_angle(rotation, rotation_value, 1)
	#var t = create_tween()
	#t.tween_property(self, "rotation", rotation_value, 0.075)
	#$DirectionIndicator.rotate_to_direction(new_direction)
	self.rotation = rotation_value
	
func _ready():
	self.sprite = $Sprite
	
func place(x: int,y: int):
	var coordinates = VisualBoardTools.spirit_tile_into_visual(Vector2(x,y))
	self.position = Vector2(coordinates.x, coordinates.y)
	print(self.position)
	pass
