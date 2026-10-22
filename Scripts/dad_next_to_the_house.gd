extends Node2D

@onready var player = %Player
@onready var talk_button = $"Talk Button"
@onready var player_check = $"Talk Button/Player Check"
var dadType = -1

var inDial = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 3 || GameManager.StoryStage == 6:
		dadType = 1
		visible = true
	elif GameManager.StoryStage == 9:
		dadType = 2
		visible = true
	else:
		dadType = -1
		visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		if player.hatSprite.animation == "Up" && player_check.has_overlapping_bodies():
			talk_button.disabled = false
			talk_button.visible = true
			if (GameManager.StoryStage == 3 || GameManager.StoryStage == 6):
				dadType = 1
			elif GameManager.StoryStage == 9:
				dadType = 2
		else:
			dadType = -1
			talk_button.disabled = true
			talk_button.visible = false
			pass
			
	else:
		$Dad.process_mode = Node.PROCESS_MODE_DISABLED
		talk_button.disabled = true
		
	if inDial && Input.is_action_just_pressed("LMB") && !GameManager.TextSlowShowing:
		inDial = false
		talk_button.visible = true
		GameManager.InCutscene = false
		GameManager.SetDialog()
	pass


func _on_talk_button_pressed():
	if !inDial:
		inDial = true
		talk_button.visible = false
		GameManager.InCutscene = true
		if dadType == 1:
			GameManager.SetDialog("Anak, ang ate mo ay doon sa kanan.", true, 1, GameManager._1_dad_calm_nohat, 3)
		elif dadType == 2:
			GameManager.SetDialog("Anak, kumuha mo ng mga iklog at pakainin mo ang mga manok", true, 1, GameManager._1_dad_calm_nohat, 3)
	
	pass # Replace with function body.
