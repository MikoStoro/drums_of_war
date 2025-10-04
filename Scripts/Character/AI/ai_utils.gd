class_name AI_utils

static func get_nearest_player_dir(my_pos : Vector2):
	var players : Array[Character] = GlobalComponents.character_manager.get_players()
	var player : Character = players[0] 
	var player_pos = player.get_spirit_position().get_vector2()
	var diff = (player_pos - my_pos)
	return Direction_Tools.get_direction_index_AI(diff)
	
