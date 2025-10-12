extends BaseAIController
class_name ChargerAIController

var action : BaseAction = RamAction.new()
var action_direction : int = -1

#to be overriden
func _input_window_enter():
	self.spirit.debug_display = "A"
	action_direction = AI_utils.get_nearest_player_dir(self.spirit.coordinates.get_vector2())
	
#to be overriden
func _input_window_leave():
	if action_direction > -1:
		action.perform_action(self, spirit, action_direction)

#to be overriden
func _stop_action():
	action.end_action(self)

#to be overriden
func _on_beat():
	pass
	
func _ready() -> void:
	self.controls = PlayerControls.new()
	self.controls.is_keyboard = false
	super._ready()
