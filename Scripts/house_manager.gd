extends Node2D
#
var HousePart = 1
@onready var player_room_cam = $"Player Room Cam"
# Called when the node enters the scene tree for the first time.
func _ready():
	#player_room_cam.enabled = true
	#$Player/Camera.enabled = !player_room_cam.enabled
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if HousePart == 0:
		player_room_cam.enabled = false
	else:
		player_room_cam.enabled = true
	$Player/Camera.enabled = !player_room_cam.enabled
	pass
