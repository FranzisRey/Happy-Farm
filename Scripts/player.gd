extends CharacterBody2D


const SPEED = 3000.0
var animationFrame = 0
var dia = 1

@onready var bodySprite = $BodySprite
@onready var armSprite = $ArmSprite
@onready var hatSprite = $HatSprite
@onready var camera = $Camera
@export var enabledLol = true
@export var canMove = true

func _ready():
	camera.enabled = enabledLol
	if GameManager.saved_player_pos.is_finite() && get_tree().current_scene.name == "Main Farm":
		position = GameManager.saved_player_pos
	if get_tree().current_scene.name != "Main Farm":
		hatSprite.visible = false
		
	if GameManager.StoryStage == 1 || GameManager.StoryStage == 2:
		position = Vector2(398,-568)
	
	await get_tree().create_timer(0.1).timeout
	
	$Camera.position_smoothing_enabled = true
	pass

func _physics_process(delta):
	$Camera.global_position.x = round(global_position.x)
	$Camera.global_position.y = round(global_position.y)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	camera.enabled = enabledLol
	var xDir = Input.get_axis("Left", "Right")
	var yDir = Input.get_axis("Up", "Down")
	var isMoving = 0
	if !(!canMove || GameManager.InCutscene):
		if xDir:
			velocity.x = xDir * SPEED * delta
			isMoving = true
		else:
			velocity.x = 0
			
		if yDir:
			velocity.y = yDir * SPEED * delta
			isMoving = true
		else:
			velocity.y = 0
	else:
		velocity = Vector2.ZERO
	velocity.normalized()
	# Manage the animation
	if isMoving:
		animationFrame = (animationFrame + 1) % 4
		if xDir == 1 && !yDir:
			bodySprite.play("Right")
			armSprite.play("Right")
			hatSprite.play("Right")
		elif xDir == -1 && !yDir:
			bodySprite.play("Left")
			armSprite.play("Left")
			hatSprite.play("Left")
		
		if yDir == -1:
			bodySprite.play("Up")
			armSprite.play("Up")
			hatSprite.play("Up")
		elif yDir == 1:
			bodySprite.play("Down")
			armSprite.play("Down")
			hatSprite.play("Down")
			
	else:
		bodySprite.stop()
		armSprite.stop()
		hatSprite.stop()
		animationFrame = 0
	
	global_position.x = round(global_position.x)
	global_position.y = round(global_position.y)
	#$Camera.global_position.x = roundi($Camera.global_position.x)
	#$Camera.global_position.y = roundi($Camera.global_position.y)
	#$Camera.global_position.x = round(global_position.x)
	#$Camera.global_position.y = round(global_position.y)
	move_and_slide()
	
