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
		current_action.perform_action(self)
		change_state("ACTION")

func _stop_action():
	current_action.end_action(self)
	change_state("BLOCKED")

func _on_beat():
	pass

func perform_action(action):
	change_state("ORDERED")
	current_action = action
	print("Ordered: " + current_action.name)
