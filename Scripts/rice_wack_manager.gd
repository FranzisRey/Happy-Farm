extends Node2D
# Sickle it the rice getting wacked, im not changing the name
@onready var mouse_manager = $"Mouse Manager"
@onready var rice_getting_whacked = $"Mouse Manager/Sickle/Rice getting whacked"
@onready var _3_big = $"Mouse Manager/Sickle/3Big"
@onready var _2_big = $"Mouse Manager/Sickle/2Big"
@onready var _1_big = $"Mouse Manager/Sickle/1Big"
@onready var sickle = $"Mouse Manager/Sickle"
@onready var hit_timer = $"Mouse Manager/HitTimer"
@onready var rice_wack_particle = $"Mouse Manager/Sickle/RiceWackParticle"
var isHitted = false
var lastSickleVel:Vector2
var Health = 10
var howManyLeft = 5
var isDone = false
var totalEgg
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN # TODO uncomment when done
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(howManyLeft)
	$RiceCollectr.frame = 5 - howManyLeft
	if rice_getting_whacked.frame == 0:
		_3_big.set_deferred("disabled", false)
		_2_big.set_deferred("disabled", true)
		_1_big.set_deferred("disabled", true)
		rice_wack_particle.emission_rect_extents.x = 30
	elif rice_getting_whacked.frame == 1:
		_3_big.set_deferred("disabled", true)
		_2_big.set_deferred("disabled", false)
		_1_big.set_deferred("disabled", true)
		rice_wack_particle.emission_rect_extents.x = 20
	elif rice_getting_whacked.frame == 2:
		_3_big.set_deferred("disabled", true)
		_2_big.set_deferred("disabled", true)
		_1_big.set_deferred("disabled", false)
		rice_wack_particle.emission_rect_extents.x = 30
	elif rice_getting_whacked.frame == 3:
		if !$AnimationPlayer.is_playing() && howManyLeft != 0:
			
			howManyLeft -= 1
			if howManyLeft != 0:
				$AnimationPlayer.play("Hand Go to Left")
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				await get_tree().create_timer(.5 , false).timeout
				rice_getting_whacked.frame = 0
				get_viewport().warp_mouse(Vector2(160,90))
				await get_tree().create_timer(.5 , false).timeout
				Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
				Health = 10
		if howManyLeft == 0:
			isDone = true
			GameManager.saved_player_pos = Vector2(752, 200)
			await get_tree().create_timer(.5, false).timeout
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			GameManager.ChangeSceneNormal("res://Scenes/main_farm.tscn")
			GameManager.StoryStage = 8
		_3_big.set_deferred("disabled", true)
		_2_big.set_deferred("disabled", true)
		_1_big.set_deferred("disabled", true)
		rice_wack_particle.emission_rect_extents.x = 30
	if mouse_manager.sickle.get_colliding_bodies().size() >= 1 && !isHitted && 1000 <= sickle.linear_velocity.length() && hit_timer.is_stopped() && Health > 0:
		
		hit_timer.start()
		Health = Health-1
		isHitted = true
		if Health >= 9:
			rice_getting_whacked.frame = 0
		elif Health >= 5:
			rice_getting_whacked.frame = 1
		elif Health >= 2:
			rice_getting_whacked.frame = 2
		elif Health <= 0:
			rice_getting_whacked.frame = 3
		rice_wack_particle.restart()
	
	elif mouse_manager.sickle.get_colliding_bodies().size() == 0:
		isHitted = false
	lastSickleVel = sickle.linear_velocity
	
	pass
