extends Node2D

@onready var player = %Player
@onready var sister = $Sister
var dialStage = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 5:
		GameManager
		dialStage = 1
		player.hatSprite.play("Right")
		player.bodySprite.play("Right")
		player.armSprite.play("Right")
		sister.arm.play("Up")
		sister.hat.play("Up")
		sister.body.play("Up")
		GameManager.InCutscene = true
		visible = true
		await get_tree().create_timer(1.0).timeout
		if GameManager.rice_cut_rank >= 6:
			GameManager.SetDialog("Maayos pa ang pagtatabas mo kahit ilang taon nang nakalipas!", true, 1, GameManager._6_sister_joyful, 3)
			pass
		elif GameManager.rice_cut_rank >= 4:
			GameManager.SetDialog("Parang hindi ka umalis ng ilang taon! magaling ka pa rin diyan!", true, 1, GameManager._2_sister_confused, 3)
			pass
		elif GameManager.rice_cut_rank >= 2:
			GameManager.SetDialog("Masyado kang nahirapan don, pero anong magagawa, ilang taon na ang nakalipas.", true, 1, GameManager._1_sister_calm, 3)
			pass
		elif GameManager.rice_cut_rank >= 1:
			GameManager.SetDialog("Ano yon? Nakakalungkot lang panoorin, sa totoo lang.", true, 1, GameManager._4_sister_annoyed, 3)
			pass
		
	else:
		sister.process_mode = Node.PROCESS_MODE_DISABLED
		visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if dialStage != -1 && Input.is_action_just_pressed("LMB") && GameManager.rice_cut_rank >= 6 && !GameManager.TextSlowShowing:
		dialStage += 1
		match dialStage:
			2:
				GameManager.SetDialog("Salamat ate.", true, 1, GameManager._1_player_calm, 2)
			3:
				DialEnd()
				
	elif dialStage != -1 && Input.is_action_just_pressed("LMB") && GameManager.rice_cut_rank >= 4 && !GameManager.TextSlowShowing:
		print("yea")
		dialStage += 1
		match dialStage:
			2:
				DialEnd()
				
	elif dialStage != -1 && Input.is_action_just_pressed("LMB") && GameManager.rice_cut_rank >= 2 && !GameManager.TextSlowShowing:
		dialStage += 1
		match dialStage:
			2:
				GameManager.SetDialog("Back to basics muna ako.", true, 1, GameManager._2_player_confused, 2)
			3:
				DialEnd()
				
	elif dialStage != -1 && Input.is_action_just_pressed("LMB") && GameManager.rice_cut_rank >= 1 && !GameManager.TextSlowShowing:
		dialStage += 1
		match dialStage:
			2:
				GameManager.SetDialog("Sorry na lang ate.", true, 1, GameManager._2_player_confused, 2)
			3:
				DialEnd()
	pass
	
	
func DialEnd():
	GameManager.StoryStage = 6
	sister.process_mode = Node.PROCESS_MODE_DISABLED
	GameManager.SetDialog()
	GameManager.PlayBlackAnim(0)
	await get_tree().create_timer(1, false).timeout
	visible = false
	GameManager.PlayBlackAnim(1)
	dialStage = -1
	GameManager.InCutscene = false
