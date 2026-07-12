class_name NpcActionData

var action : BaseAction = null
var direction : int = 0

func _init(action : BaseAction, direction: int):
	self.action = action
	self.direction = direction
