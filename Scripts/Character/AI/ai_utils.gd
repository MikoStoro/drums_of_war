class_name AI_utils

static func get_nearest_player_dir(my_pos : Vector2):
	var players : Array[Character] = GlobalComponents.character_manager.get_players()
	var player : Character = players[0] 
	var player_pos = player.get_spirit_position().get_vector2()
	return Direction_Tools.get_direction_angle_v(player_pos - my_pos)
	
