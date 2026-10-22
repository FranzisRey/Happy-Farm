extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 12:
		$"../DarkPolyShape".visible = true
	else:
		$"../DarkPolyShape".visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.StoryStage == 12:
		$"../DarkPolyShape".visible = true
	else:
		$"../DarkPolyShape".visible = false
	pass
