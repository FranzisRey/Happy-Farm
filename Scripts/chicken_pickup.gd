extends RigidBody2D

var over_mouse = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(over_mouse && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && abs(get_global_mouse_position().y-global_position.y) >= 1):
		linear_velocity.y = (get_global_mouse_position().y-global_position.y)*1000*delta
	else:
		linear_velocity.y = 0
	pass
	


func _on_mouse_entered():
	over_mouse = true
	pass # Replace with function body.


func _on_mouse_exited():
	over_mouse = false
	pass # Replace with function body.
