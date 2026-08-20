extends Node2D

@onready var player_check = $"Talk/Player Check"
@onready var player = %Player
@onready var sister = $Sister
@onready var talk = $Talk
var StoryStage3MainCutscene = false
var dialStage = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 3:
		visible = true
		pass
	else:
		talk.disabled = true
		visible = false
		sister.process_mode = Node.PROCESS_MODE_DISABLED
		player_check.monitoring = false
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	
	
	if GameManager.StoryStage == 3:
		if player_check.has_overlapping_bodies():
			talk.disabled = false
			talk.visible = true
		else:
			talk.disabled = true
			talk.visible = false
			
			
		if StoryStage3MainCutscene:
			if Input.is_action_just_pressed("LMB") && !talk.is_hovered() && !GameManager.TextSlowShowing:
				dialStage += 1
				match dialStage:
					2:
						GameManager.SetDialog("Itatabas muna natin ang palay, tapos iwawasak natin para maghiwalay ang palay.", true, 1, GameManager._1_sister_calm, 2) # sis 1
					3:
						GameManager.SetDialog("Sige.", true, 1, GameManager._1_player_calm, 2) # player 1
					4:
						GameManager.SetDialog()
						GameManager.PlayBlackAnim(0)
						await get_tree().create_timer(.50, false).timeout
						StoryStage3MainCutscene = false
						GameManager.StoryStage = 4
						GameManager.ChangeSceneNormal("res://Scenes/rice_cut_scene.tscn")
			
	pass


func _on_talk_pressed():
	StoryStage3MainCutscene = true
	GameManager.InCutscene = true
	GameManager.PlayBlackAnim(0)
	await get_tree().create_timer(.15, false).timeout
	player.global_position = sister.global_position + Vector2(0,20)
	player.hatSprite.play("Up")
	player.bodySprite.play("Up")
	player.armSprite.play("Up")
	await get_tree().create_timer(.5, false).timeout
	GameManager.PlayBlackAnim(1)
	await get_tree().create_timer(1, false).timeout
	dialStage = 1
	GameManager.SetDialog("Anong uunahin muna natin?", true, 1, GameManager._1_player_calm, 2) #player 1
	pass # Replace with function body.
