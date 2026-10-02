extends Node2D
# Called when the node enters the scene tree for the first time.
var textShowing = false
func _ready():
	
	if GameManager.StoryStage == 7:
		GameManager.InCutscene = true
		await get_tree().create_timer(.5, false).timeout
		textShowing = true
		GameManager.SetDialog("Madali na yan, wasakin mo yung iyong palay dun sa kahoy don.", true, 1, GameManager._1_sister_calm,2) # sister 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("LMB") && !GameManager.TextSlowShowing && textShowing:
		GameManager.InCutscene = false
		GameManager.SetDialog()
	pass
