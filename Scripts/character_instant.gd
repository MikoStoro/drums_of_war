extends Character

func _input_window_enter():
	if state == states["BLOCKED"]:
		change_state("LISTENING")
	if state == states["ORDERED"]:
		change_state("LISTENING")

func _input_window_leave():
	if state == states["LISTENING"] or state == states["MISSED"]:
		change_state("BLOCKED")
	if state == states["ORDERED"]:
		action_timer.start()
		current_action.perform_action(self, spirit)
		change_state("ACTION")

func _stop_action():
	current_action.end_action(self)
	change_state("BLOCKED")

func _on_beat():
	pass

func order_action(action):
	change_state("ORDERED")
	current_action = action
	print("Ordered: " + current_action.name)
	
func _ready() -> void:
	super._ready()
	self.board = $"../Board"
	var e = BoardEntity.new()
	e.debug_display = "C"
	e.coordinates = Coordinates.new(1,1)
	self.spirit = e
	self.board.place_entity(e)
