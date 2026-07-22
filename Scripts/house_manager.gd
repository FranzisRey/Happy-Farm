extends Node2D
#
@export var HousePart:int = 0

@onready var player_room_cam = $"Players Room/Player Room Cam"
@onready var player_door_1 = $"Player Door/Player Door 1"
@onready var player_door_2 = $"Player Door/Player Door 2"
@onready var room_trans = $"Player Door/Room Trans"
@onready var player = $Player

@onready var exit = $"Main Door/Exit"
var dialWait = true

var dialogueStage = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if GameManager.StoryStage == 1:
		GameManager.InCutscene = 1
		HousePart = 1
		player.canMove = false
		dialogueStage = 1
		GameManager.SetDialog("Z ZzZZ zZZzZZ Z............", true, 0, "", 6) # player
	elif GameManager.StoryStage == 2:
		HousePart = 1
		GameManager.PlayBlackAnim(1)
	$Hitbox.visible = false
	#player_room_cam.enabled = true
	#$Player/Camera.enabled = !player_room_cam.enabled
	$Player/Camera.enabled = !player_room_cam.enabled
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#this is for story thing
	if GameManager.StoryStage == 1:
		if dialogueStage != -1:
			if Input.is_action_just_pressed("LMB") && !GameManager.TextSlowShowing && dialWait:
				dialogueStage += 1
				match(dialogueStage):
					2:
						GameManager.SetDialog("............", true, 0, "", 6) # player
					
					
					3:
						dialWait = false
						GameManager.SetDialog("", false, 0, "", 6)
						await get_tree().create_timer(2).timeout
						GameManager.PlayBlackAnim(1)
						await get_tree().create_timer(1).timeout
						GameManager.SetDialog("Bago nanamang araw.", true, 1, GameManager._1_player_calm_nohat, 6) # player 1
						dialWait = true
						
					4:
						GameManager.SetDialog("Gabi na and dating ko dito, pero nasa akin naman kung bakit.", true, 1, GameManager._1_player_calm_nohat, 3) # player 1
					5:
						GameManager.SetDialog("Siguro nagtatanghalian na sila.", true, 1, GameManager._1_player_calm_nohat, 3) # player 1
					6:
						dialogueStage = -1
						GameManager.SetDialog()
						player.canMove = true
						GameManager.InCutscene = false
						GameManager.StoryStage = 2
						
					
	
	
	
	
	
	if HousePart == 0:
		$Player/Camera.enabled = true
		player_room_cam.enabled = false
	else:
		$Player/Camera.enabled = false
		if HousePart == 1:
			player_room_cam.enabled = true
		
	
	
	if player_door_1.get_overlapping_bodies().size() >= 1:
		GameManager.PlayBlackAnim(0)
		room_trans.play("To_Player")
		await get_tree().create_timer(0.15).timeout
		GameManager.PlayBlackAnim(1)
	if player_door_2.get_overlapping_bodies().size() >= 1:
		$Player/Camera.position_smoothing_enabled = false
		room_trans.play("From_Player")
		GameManager.PlayBlackAnim(0)
		await get_tree().create_timer(0.10).timeout
		GameManager.PlayBlackAnim(1)
		await get_tree().create_timer(0.05).timeout
		$Player/Camera.position_smoothing_enabled = true
	
	
	
	if exit.get_overlapping_bodies().size() >= 1:
		GameManager.ChangeToPlace(1,1)
	pass
