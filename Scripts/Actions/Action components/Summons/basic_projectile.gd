extends AbstractCharacter
class_name BasicProjectile

var data : Dictionary


func _ready():
	self.x_pos = data["coordinates"].x
	self.y_pos = data["coordinates"].y
	self.direction = data["direction"]
	self.controller.action_direction = data["direction"]

func setup(data : Dictionary):
	self.data = data
