extends Node2D


func Save():
	var savedGame:SavedGame = SavedGame.new()
	if has_node("/root/Main Farm/Player"):
		savedGame.player_pos = $"/root/Main Farm/Player".position
	else:
		if FileAccess.file_exists("res://savegame.tres"):
			var savedgame2:SavedGame = load("res://savegame.tres")
			if get_tree().current_scene.name == "Main Farm":
				savedGame.player_pos = savedgame2.player_pos
		
	savedGame.storyStage = GameManager.StoryStage
	
	ResourceSaver.save(savedGame, "res://savegame.tres")
	
func Load():
	if FileAccess.file_exists("res://savegame.tres"):
		
		var savedgame:SavedGame = load("res://savegame.tres")
	
		GameManager.saved_player_pos = savedgame.player_pos
		GameManager.StoryStage = savedgame.storyStage
	pass

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Save()
		get_tree().quit() # default behavior
