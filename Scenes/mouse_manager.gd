extends Node2D

var CutPoints = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	CutPoints.push_front(get_global_mouse_position())
	if CutPoints.size() >= 11:
		CutPoints.pop_back()
	print(CutPoints)
	$Line2D.points = CutPoints
	pass
