extends CharacterBody2D


const SPEED = 3000.0

func _ready():
	$Camera.zoom = Vector2i(1,1)

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var xDir = Input.get_axis("Left", "Right")
	var yDir = Input.get_axis("Up", "Down")
	if xDir:
		velocity.x = xDir * SPEED * delta
	else:
		velocity.x = 0
	if yDir:
		velocity.y = yDir * SPEED * delta
	else:
		velocity.y = 0
	
	move_and_slide()
