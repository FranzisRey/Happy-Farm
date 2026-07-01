extends Node2D
#
var HousePart = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.enabled = true
	$Player/Camera.enabled = !$Camera2D.enabled
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if HousePart == 0:
		$Camera2D.enabled = false
	else:
		$Camera2D.enabled = true
	$Player/Camera.enabled = !$Camera2D.enabled
	pass
