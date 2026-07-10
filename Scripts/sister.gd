extends AnimatableBody2D


@onready var body = $Body
@onready var arm = $Arm
@onready var hat = $Hat
var animationFrame
var lastFramePos:Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	lastFramePos =  position
	if get_tree().current_scene.name != "Main Farm":
		hat.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var displacement = position - lastFramePos
	
	if !displacement.is_zero_approx():
		animationFrame = (animationFrame + 1) % 4
		if displacement.x > 0 && !displacement.y:
			body.play("Right")
			arm.play("Right")
			hat.play("Right")
		elif displacement.x < 0 && !displacement.y:
			body.play("Left")
			arm.play("Left")
			hat.play("Left")
		
		if displacement.y < 0:
			body.play("Up")
			arm.play("Up")
			hat.play("Up")
		elif displacement.y > 0:
			body.play("Down")
			arm.play("Down")
			hat.play("Down")
			
	else:
		body.stop()
		arm.stop()
		hat.stop()
		animationFrame = 0
	
	lastFramePos = position
	pass
