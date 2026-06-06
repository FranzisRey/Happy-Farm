extends CharacterBody2D


const SPEED = 3000.0
var animationFrame = 0
var dia = 1

@onready var bodySprite = $BodySprite
@onready var armSprite = $ArmSprite
@onready var hatSprite = $HatSprite


func _ready():
	pass

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var xDir = Input.get_axis("Left", "Right")
	var yDir = Input.get_axis("Up", "Down")
	var isMoving = 0
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
	#$Camera.global_position.x = roundi($Camera.global_position.x)
	#$Camera.global_position.y = roundi($Camera.global_position.y)
	if Input.is_action_just_pressed("LMB"):
		match dia:
			1:
				GameManager.SetDialog("test 1", 1)
				dia += 1
			2: 
				GameManager.SetDialog("test 2", 1)
				dia += 1
			3:
				GameManager.SetDialog("", 0)
				dia = 1
				
	move_and_slide()
	
