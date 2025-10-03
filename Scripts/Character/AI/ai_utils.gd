class_name AI_utils

func get_nearest_player(my_position : Vector2):
	var players = GlobalComponents.character_manager.get_players()
	var player = players[0]
	
