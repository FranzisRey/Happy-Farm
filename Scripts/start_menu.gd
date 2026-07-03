extends Control

func _on_button_button_down():
	if GameManager.StoryStage == 1 || GameManager.StoryStage == 2:
		GameManager.PlayBlackAnim(0)
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scenes/house.tscn")
	else:
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scenes/main_farm.tscn")
	pass # Replace with function body.
