class_name PlayerAbstractCharacter
extends AbstractCharacter

var actions : Array[BaseAction] = [ DashAction.new(), ThrustAction.new(), SlowDashAttack.new(), SummonProjectileAction.new() ]
var default_action : BaseAction = DefaultIdleAction.new()

func _init(custom_id = null):
	super()
	self.is_ai = false

func setup_action(index: int, direction : int):
	self.current_action = actions.get(index)
	self.current_action_direction = direction

func reset_action():
	self.current_action = self.default_action
