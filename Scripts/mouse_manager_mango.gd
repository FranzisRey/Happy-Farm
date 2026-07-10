extends Node2D

var TrailPoints = []
var ifMouseIsDown = false
var CutPoints = [Vector2(NAN,NAN),Vector2(NAN,NAN)]
var cutAction = false
var mouseHeld = false
signal finished

@onready var cut_timer = $"../CutTimer"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		
		if(!cutAction && !mouseHeld):
			CutPoints[0] = get_global_mouse_position()
			cut_timer.start()
		cutAction = true
		
		if(cut_timer.is_stopped()):
			if cutAction && is_nan(CutPoints[1][0]):
				CutPoints[1] = get_global_mouse_position()
				finished.emit()
			cutAction = false
		mouseHeld = true
	else:
		CutPoints = [Vector2(NAN,NAN),Vector2(NAN,NAN)]
		cut_timer.stop()
		cutAction = false
		mouseHeld = false
		
	if(cutAction):
		$Line.default_color = Color.RED
	else:
		$Line.default_color = Color.WHITE
	
	
	TrailPoints.push_front(get_global_mouse_position())
	if TrailPoints.size() >= 11:
		TrailPoints.pop_back()
	$Line.points = TrailPoints
	pass
