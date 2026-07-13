class_name NpcAbstractCharacter
extends AbstractCharacter

var npc_controller : BaseNpcController = null

func _init(custom_id = null):
	super()
	self.is_ai = true

## here AI will make decisions
func setup_action():
	var data : NpcActionData = npc_controller.setup_action()
	self.current_action = data.action
	self.current_action_direction = data.direction
