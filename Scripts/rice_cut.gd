extends AnimatedSprite2D

var GotCut = 0
var CutRank = 0
@onready var mouse_manager = $"../../Mouse Manager"
@onready var rice_cut_scene = $"../.."
var texture
# Called when the node enters the scene tree for the first time.
func _ready():
	
	texture = sprite_frames.get_frame_texture("default", 1)
	frame = randi_range(0, 7)
	flip_h = randi_range(0, 1)
	mouse_manager.finished.connect(Cut)
	rice_cut_scene.reset.connect(Reset)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func Reset():
	if GotCut:
		frame = randi_range(0, 7)
		flip_h = randi_range(0, 1)
		GotCut = 0
		material.set("shader_parameter/offset", 32)
		material.set("shader_parameter/slope", 0)
func Cut():
	var CutPoints = mouse_manager.CutPoints
	if !is_nan(CutPoints[1][0]) && !GotCut:
		var minV = CutPoints[0].min(CutPoints[1])
		var maxV = CutPoints[0].max(CutPoints[1])
		if minV.x <= global_position.x-(texture.get_size().x/3) && global_position.x+(texture.get_size().x/3) <= maxV.x:
			var slope = -tan(CutPoints[0].angle_to_point(CutPoints[1]))
			var _offset = ((minV+maxV)/2)
			
			var new_offset = -_offset.y+global_position.y-slope*(_offset.x-global_position.x)+(texture.get_height()/2)
			if new_offset < 32 && new_offset > 0:
				material.set("shader_parameter/offset", (new_offset))
				material.set("shader_parameter/slope", -slope* (-1 + (2*int(flip_h))))
				rice_cut_scene.CutTotalRank += ceili((min(abs(1/slope),10) + min(abs(80/(4-new_offset)), 40)) / 10)
				GotCut = 1
	elif is_nan(CutPoints[1][0]):
		pass
