extends Node2D

var TrailPoints = []
var ifMouseIsDown = false
var CutPoints = [Vector2(NAN,NAN),Vector2(NAN,NAN)]
var cutAction = false
var mouseHeld = false
signal finished
@onready var rice_cut_scene = $".."

@onready var cut_timer = $"../CutTimer"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.is_action_pressed("LMB")) && rice_cut_scene.canCut && !GameManager.InCutscene:
		if(!cutAction && !mouseHeld):
			CutPoints[0] = get_global_mouse_position()
			cut_timer.start()
		cutAction = true
		
		if(cut_timer.is_stopped()):
			if cutAction && is_nan(CutPoints[1][0]):
				
				
				#print(abs(first_angle - (total_angle / 8))*(180/PI))
				CutPoints[1] = get_global_mouse_position()
				
				var cutPointsMid = CutPoints[0].lerp(CutPoints[1], .5)
				var min_dis = INF
				for i in range(10):
					min_dis = min(min_dis, $Line.points[i].distance_to(cutPointsMid))
					
				print(min_dis)
				if min_dis <= 10:
					finished.emit()
				else:
					print("- please")
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
