extends Node2D

var dialStage = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 8:
		GameManager.InCutscene = true
		%Player.position = Vector2(752, 200)
		%Player.hatSprite.play("Up")
		%Player.bodySprite.play("Up")
		%Player.armSprite.play("Up")
		$Sister.hat.play("Right")
		$Sister.body.play("Right")
		$Sister.arm.play("Right")
		visible = true
		await get_tree().create_timer(.5, false).timeout
		dialStage = 1
		GameManager.SetDialog("Sige, ayos na yan. Tutulungan ko ang tatay sa paggawa ng hapunan natin, ikaw na ang bahala sa pagpapakain ng mga manok, kumuha ka na rin ng ilang piraso ng itlog para sa hapunan natin.", true, 1,GameManager._1_sister_calm, 2)
	else:
		$Sister.process_mode = Node.PROCESS_MODE_DISABLED
		visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.StoryStage != 8:
		$Sister.process_mode = Node.PROCESS_MODE_DISABLED
		visible = false
	if Input.is_action_just_pressed("LMB") && !GameManager.TextSlowShowing && dialStage != -1:
		dialStage += 1
		match(dialStage):
			2:
				GameManager.SetDialog("Siguro alam mo pa kung paano yon.", true, 1,GameManager._1_sister_calm, 2)
			3:
				GameManager.SetDialog("Paano naman dun sa pagtatanim ulit?", true, 1, GameManager._1_player_calm, 2)
			4:
				GameManager.SetDialog("Ayos na yon, pati may kasama rin ako sa paggawa.", true, 1,GameManager._1_sister_calm, 2)
			5:
				GameManager.SetDialog("Yun kasinta mo nanaman ano?", true, 1, GameManager._6_player_joyful, 2)
			6:
				GameManager.SetDialog("Matuwa ka nga at may tutulong sa palay natin.", true, 1, GameManager._1_sister_calm, 2)
			7:
				GameManager.SetDialog("Sige na, mangunguna na ako.", true, 1, GameManager._1_player_calm, 2)
			8:
				dialStage = -1
				GameManager.SetDialog()
				GameManager.PlayBlackAnim(0)
				await get_tree().create_timer(.5, false).timeout
				GameManager.InCutscene = false
				GameManager.PlayBlackAnim(1)
				GameManager.StoryStage = 9
				
	pass
