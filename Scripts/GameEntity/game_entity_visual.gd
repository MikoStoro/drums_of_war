extends Sprite2D
class_name GameEntityVisual
@export var entity_data: GameEntityData

func _ready() -> void:
	var parent = get_parent() 
	texture = entity_data.sprite
	
	if parent is GameEntity:
		parent.hit_recieved.connect(_on_hit_received)
		
func _on_hit_received():
	# hurt animation
	pass
