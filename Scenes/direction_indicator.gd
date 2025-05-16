extends Node2D

@onready var character_sprite = $"../Sprite2D"
var offset : Vector2 = Vector2(0,100)
var base_rotation = PI
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

func rotate_to_direction(direction : int = 0):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = character_sprite.position + offset
	self.rotation = character_sprite.rotation + base_rotation
