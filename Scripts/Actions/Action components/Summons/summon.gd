extends Node
class_name Summon

@onready var controller : BaseAIController
@onready var visual = $VisualProjectile
var spirit : BoardEntity = null
var debug_display: String = "S"
var x_pos
var y_pos
var direction

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
	spirit.new_events.connect(transmit_events)

func setup_visual():
	self.visual.place(x_pos, y_pos)
	self.visual.rotate_to_direction(direction)

func transmit_events(events):
	self.visual.new_orders(events)

func destruction():
	queue_free()
