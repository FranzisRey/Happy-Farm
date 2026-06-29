extends Node2D

var StoryBegStage = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.SetDialog("Story beat one", true, 0, "")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("LMB"):
		StoryBegStage += 1
		
		
	match StoryBegStage:
		2:
			GameManager.SetDialog("Story beat two", true, 0, "")
		3:
			GameManager.SetDialog("", false, 0, "")
			GameManager.StoryStage = 2
			get_tree().change_scene_to_file("res://Scenes/main_farm.tscn")
	pass
