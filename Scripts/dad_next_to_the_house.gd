extends Node2D

@onready var player = %Player
@onready var talk_button = $"Talk Button"
@onready var player_check = $"Talk Button/Player Check"

var inDial = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 3 || GameManager.StoryStage == 6:
		visible = true
	else:
		visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		if (GameManager.StoryStage == 3 || GameManager.StoryStage == 6) && player.hatSprite.animation == "Up" && player_check.has_overlapping_bodies():
			talk_button.disabled = false
			talk_button.visible = true
		else:
			talk_button.disabled = true
			talk_button.visible = false
			pass
			
	else:
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
		GameManager.SetDialog("Ang ate mo ay doon sa kanan.", true, 1, GameManager._1_dad_calm_nohat, 3)
		
	
	pass # Replace with function body.
