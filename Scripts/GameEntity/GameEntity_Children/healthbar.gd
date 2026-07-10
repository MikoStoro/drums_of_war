extends ProgressBar

@export var game_entity: Node2D

func _ready() -> void:
	game_entity.damage_taken.connect(_on_damage_taken)

func _on_damage_taken(amount: int) -> void:
	value -= amount
