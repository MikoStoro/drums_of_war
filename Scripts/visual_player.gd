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
			#move(event)
			print("where coords")

func _process(delta: float) -> void:
	pass

	# only for animating, no damage dealt here
	# if I understand correctly, AnimationPlayer for using keyframes 
	# and AnimationSprite for spritesheets
func attack():
	animation_sprite.play("attack")

func play_animation(name: String) -> void:
	# not sure how to properly corelate speed in code with animation player
	animation.speed_scale = 5
	animation.play(name)
	
	
func move(x: int, y: int) -> void:
	play_animation("move")
	var coords = Vector2(x,y) 
	var new_position = coords * tile_size
	var tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.2) 
	
	
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(3,2)
	if event.is_action_pressed("player1_action1"):
			move(2,1)
			attack()
	
	
