extends Node2D

@onready var sister = $Sister
@onready var dad = $Dad
@onready var no_leaving = $"No leaving"
@onready var player = $"../Player"
@onready var player_is_close = $"Sit Down/PlayerIsClose"
@onready var sit_down = $"Sit Down"
var tryingToLeave = false

var StoryStage2MainCutscene = false
var dialogue = -1
var dialWait = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sister/CollisionShape2D.disabled = true
	$Dad/CollisionShape2D.disabled = true
	if GameManager.StoryStage != 2:
		no_leaving.monitoring = false
		player_is_close.monitoring = false
		visible = false
	else:
		visible = true
		dad.body.play("Up")
		dad.arm.play("Up")
		dad.hat.play("Up")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(dialogue)
	if GameManager.StoryStage == 2:
		no_leaving.monitoring = true
		player_is_close.monitoring = true
		
		visible = true
		dad.body.play("Up")
		dad.arm.play("Up")
		dad.hat.play("Up")
		if StoryStage2MainCutscene:
			if Input.is_action_just_pressed("LMB") && !sit_down.is_hovered() && !GameManager.TextSlowShowing && dialWait:
				dialogue += 1
				match dialogue:
					2:
						GameManager.SetDialog("Pero handa na naman ang tanghalian, sumabay ka na lang sa amin.", true, 1, GameManager._1_sister_calm_nohat, 3) # sis 1
					3:
						sister.hat.play("Down")
						sister.body.play("Down")
						sister.arm.play("Down")
						await get_tree().create_timer(.1).timeout
						dialWait = false
						GameManager.SetDialog()
						GameManager.PlayBlackAnim(0)
						await get_tree().create_timer(2).timeout
						GameManager.PlayBlackAnim(1)
						await get_tree().create_timer(1).timeout
						GameManager.SetDialog("Anak, salamat at dumating ka para matulungan kami, pasensya na lang sa abala.", true, 1, GameManager._2_dad_confused_nohat, 4) # dad 2
						dialWait = true
					4:
						GameManager.SetDialog("Wala po yan 'tay, hindi naman po kayo malayo sa aking trabaho.", true, 1, GameManager._1_player_calm_nohat, 2) # player 1
					5:
						GameManager.SetDialog("Pati nakakainip rin sa Bahay minsan, maganda nga po at nakakagawa rin naman ang katawan dine.", true, 1, GameManager._1_player_calm_nohat, 2) # player 1
					6:
						GameManager.SetDialog("Sige anak. Para magsimula tayo, ngayong hapon na ito, tuturuan ko ikaw sa palay namin, ulit.", true, 1, GameManager._1_dad_calm_nohat, 4) # dad 1
					7:
						dialWait = false
						GameManager.SetDialog("'tay, siguro alam ko pa nama-", true, 1, GameManager._2_player_confused_nohat, 3) # player 2
						await GameManager.TextIsFinsihed
						await get_tree().create_timer(.1).timeout
						GameManager.SetDialog("Ay tay kita nyo ba po? Kaputi-puti na ni kuya baka matakot siya sa araw!", true, 1, GameManager._6_sister_joyful_nohat, 2) # sis 6
						dialWait = true
					8:
						player.hatSprite.play("Right")
						player.bodySprite.play("Right")
						player.armSprite.play("Right")
						GameManager.SetDialog("Hala ka Ellia, ilang taon na ang nakalipas ganyan ka pa rin sa akin.", true, 1, GameManager._4_player_annoyed_nohat, 2) # player 4
					9:
						player.hatSprite.play("Down")
						player.bodySprite.play("Down")
						player.armSprite.play("Down")
						GameManager.SetDialog("Eh paano ga, kalalaki mong tao ay ikaw pa ang maarte sa mga gawaing noong bata pa tayo.", true, 1, GameManager._6_sister_joyful_nohat, 3) # sis 6
					10:
						GameManager.SetDialog("O tama na kayong dalawa, dahil dyan kayo ang magtutulungan ngayon sa palay.", true, 1, GameManager._3_dad_angry_nohat, 4) # dad 3
					11:
						GameManager.SetDialog("Marunong ka na rin Ellia, ikaw na ang magturo sa kapatid mo dun sa pag-refine ng bigas.", true, 1, GameManager._3_dad_angry_nohat, 4) # dad 3
					12:
						GameManager.SetDialog("haha nadamay ka rin.", true, 1, GameManager._6_player_joyful_nohat, 2) # player 6
					13:
						dialWait = false
						GameManager.SetDialog()
						GameManager.PlayBlackAnim(0)
						await get_tree().create_timer(.1).timeout
						$Camera2D.enabled = false
						player.enabledLol = true
						player.position = Vector2(179.0 ,-170.0)
						
						await get_tree().create_timer(.5).timeout
						GameManager.PlayBlackAnim(1)
						GameManager.InCutscene = false
						GameManager.StoryStage = 3
						StoryStage2MainCutscene = 0
						dialogue = -1
						
						no_leaving.monitoring = false
						player_is_close.monitoring = false
						visible = false
						$"../Table and Chair/TableCol".process_mode = Node.PROCESS_MODE_INHERIT
						
						
			
		
		
		if player_is_close.has_overlapping_bodies() && !GameManager.InCutscene:
			sit_down.visible = true
			sit_down.disabled = 0
		else:
			sit_down.visible = false
			sit_down.disabled = 1
		
		
		if tryingToLeave && Input.is_action_just_pressed("LMB") && !GameManager.TextSlowShowing:
			tryingToLeave = false
			GameManager.InCutscene = false
			GameManager.SetDialog("", false, 0, "", -1)
		
		if no_leaving.has_overlapping_bodies() && !GameManager.InCutscene:
			GameManager.SetDialog("Kuya, saan ka pupunta?", true, 0, "", 3)
			tryingToLeave = true
			GameManager.InCutscene = true
			player.position.y = -90
			print("1")
		
	pass


func _on_sit_down_button_down():
	
	StoryStage2MainCutscene = true
	GameManager.InCutscene = true
	GameManager.PlayBlackAnim(0)
	await get_tree().create_timer(.15).timeout
	$"../Table and Chair/TableCol".process_mode = Node.PROCESS_MODE_DISABLED
	player.position = Vector2(179.0 ,-153.0)
	$Camera2D.enabled = true
	player.enabledLol = false
	player.hatSprite.play("Down")
	player.bodySprite.play("Down")
	player.armSprite.play("Down")
	await get_tree().create_timer(.5).timeout
	GameManager.PlayBlackAnim(1)
	await get_tree().create_timer(1).timeout
	dialogue = 1
	GameManager.SetDialog("Tanghali ka na, naubosan ka ng almusal kuya.", true, 1, GameManager._1_sister_calm_nohat, 3) # sister 1
	sister.hat.play("Left")
	sister.body.play("Left")
	sister.arm.play("Left")
	pass # Replace with function body.
