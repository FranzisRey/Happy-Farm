extends Node2D

@onready var player_check = $"Player Check"
@onready var player = %Player
@onready var sister = $Sister
@onready var talk = $"Player Check/Talk"
var StoryStage3MainCutscene = false
var dialStage = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 3:
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
			player_check.visible = true
		else:
			talk.disabled = true
			player_check.visible = false
			
			
		if StoryStage3MainCutscene:
			if Input.is_action_just_pressed("LMB") && !talk.is_hovered() && !GameManager.TextSlowShowing:
				dialStage += 1
				match dialStage:
					2:
						GameManager.SetDialog("Itatabas muna natin ang palay, tapos iwawasak natin para maghiwalay ang palay", true, 0, "", 3)
					3:
						GameManager.SetDialog("Sige.", true, 0, "", 2)
					4:
						GameManager.SetDialog()
						GameManager.PlayBlackAnim(0)
						await get_tree().create_timer(.15).timeout
						StoryStage3MainCutscene = false
						GameManager.StoryStage = 4
						GameManager.ChangeSceneNormal("res://Scenes/rice_cut_scene.tscn")
			
	pass


func _on_talk_pressed():
	StoryStage3MainCutscene = true
	GameManager.InCutscene = true
	GameManager.PlayBlackAnim(0)
	await get_tree().create_timer(.15).timeout
	player.position = Vector2(1015.0 ,221.0)
	player.hatSprite.play("Up")
	player.bodySprite.play("Up")
	player.armSprite.play("Up")
	await get_tree().create_timer(.5).timeout
	GameManager.PlayBlackAnim(1)
	await get_tree().create_timer(.08).timeout
	dialStage = 1
	GameManager.SetDialog("Anong uunahin muna natin?", true, 0, "", 2)
	pass # Replace with function body.
