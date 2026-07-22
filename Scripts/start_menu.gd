extends Control

func _on_button_button_down():
	if GameManager.StoryStage == -1:
		GameManager.StoryStage = 1
		
		
	if GameManager.StoryStage == 1:
		GameManager.PlayBlackAnim(0)
		await get_tree().create_timer(.75).timeout
		GameManager.ChangeSceneNormal("res://Scenes/house.tscn", false)
	elif GameManager.StoryStage == 2:
		GameManager.PlayBlackAnim(0)
		await get_tree().create_timer(.75).timeout
		GameManager.ChangeSceneNormal("res://Scenes/house.tscn")
	elif GameManager.StoryStage == 3:
		GameManager.PlayBlackAnim(0)
		await get_tree().create_timer(.75).timeout
		GameManager.ChangeSceneNormal("res://Scenes/main_farm.tscn")
	elif GameManager.StoryStage == 4:
		GameManager.PlayBlackAnim(0)
		await get_tree().create_timer(.75).timeout
		GameManager.ChangeSceneNormal("res://Scenes/rice_cut_scene.tscn")
	pass # Replace with function body.
