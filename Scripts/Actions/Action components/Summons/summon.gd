extends Node
class_name Summon

@onready var controller : BaseAIController
var spirit : BoardEntity = null
var debug_display: String = "S"
var x_pos
var y_pos

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup_entity():
	self.spirit = BoardEntity.new(x_pos, y_pos)
	self.spirit.debug_display = self.debug_display
	GlobalComponents.abstract_board.place_entity(spirit)
	self.controller.link_spirit(self.spirit)
	spirit.destroyed.connect(destruction)

func destruction():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
