extends BaseAIController
class_name ProjectileController 

var action : BaseAction = ProjectileAction.new()
var action_direction = -1

func _input_window_enter():
	self.spirit.debug_display = "P"

func _input_window_leave():
	if action_direction > -1:
		action.perform_action(self, spirit, action_direction)
