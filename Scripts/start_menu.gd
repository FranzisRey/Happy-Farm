extends Control

func _on_button_button_down():
	if GameManager.StoryStage == 1:
		get_tree().change_scene_to_file("res://Scenes/house.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/main_farm.tscn")
	pass # Replace with function body.
