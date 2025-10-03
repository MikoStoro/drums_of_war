class_name AI_utils

func get_nearest_player(my_pos : Vector2):
	var players : Array[Character] = GlobalComponents.character_manager.get_players()
	var player : Character = players[0] 
	var player_pos = player.get_spirit_position()
	##TODO
	
