extends Sprite2D

var GotCut = false

@export var mouse_manager: Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var CutPoints = mouse_manager.CutPoints
	if !is_nan(CutPoints[1][0]) && !GotCut:
		var minV = CutPoints[0].min(CutPoints[1])
		var maxV = CutPoints[0].max(CutPoints[1])
		if minV.x <= global_position.x-(texture.get_size().x/2) && global_position.x+(texture.get_size().x/2) <= maxV.x:
			var slope = -tan(CutPoints[0].angle_to_point(CutPoints[1]))
			var offset = ((minV+maxV)/2)
			print(offset)
			material.set("shader_parameter/offset", -offset.y+global_position.y-slope*(offset.x-global_position.x)+(texture.get_height()/2))
			material.set("shader_parameter/slope", slope)
			GotCut = true
	elif is_nan(CutPoints[1][0]):
		GotCut = false
	pass
