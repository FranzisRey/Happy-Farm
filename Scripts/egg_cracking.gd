extends RigidBody2D

var lastVelocity: Vector2
var impactForce
# Called when the node enters the scene tree for the first time.
func _ready():
	lastVelocity = Vector2(0,0)
	pass # Replace with function body.

func _on_body_entered(body):
	print(lastVelocity.length())
	if lastVelocity.length() >= 200:
		$Polygon2D.visible = false
		freeze = true
		$CollisionShape.disabled = true
		$CPUParticles2D.emitting = true
		await get_tree().create_timer(2).timeout
		queue_free()
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lastVelocity = linear_velocity
	pass
