extends Control

func _on_button_button_down():
	if GameManager.StoryStage >= 2:
		get_tree().change_scene_to_file("res://Scenes/main_farm.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/beginning_cutscene.tscn")
	pass # Replace with function body.
