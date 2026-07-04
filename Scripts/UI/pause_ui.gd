extends PanelContainer
var paused := false
func _unhandled_input(event):
	if Input.is_action_pressed("pause"):
		if paused:
			visible = false
			get_tree().paused = false
			paused = false
		else:
			visible = true
			get_tree().paused = true
			paused = true
			#set_process_input(true)
