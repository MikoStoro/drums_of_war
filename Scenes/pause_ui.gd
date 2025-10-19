extends PanelContainer
var paused := false
										
func _on_resume_pressed() -> void:
	unpause()
	

func _unhandled_input(event):
	if Input.is_action_pressed("pause"):
		if paused:
			unpause()
		else:
			pause()
			
func pause():
	visible = true
	get_tree().paused = true
	paused = true
	
func unpause():
	visible = false
	get_tree().paused = false
	paused = false

func _on_exit_pressed() -> void:
	# allows for our cleanup before actually exiting
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit() 
