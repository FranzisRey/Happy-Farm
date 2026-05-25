extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		for body in get_overlapping_bodies():
			var direction: Vector2 = global_position - body.global_position
			var distance: float = direction.length()
			direction = direction.normalized()
			body.linear_velocity =  distance * direction * 1000 * delta
			print(body)
	pass
