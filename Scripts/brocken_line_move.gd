extends Sprite2D

var line_go_one = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if line_go_one >= 4:
		region_rect.position.x = fmod(region_rect.position.x - 1, 8)
		line_go_one = 0
	else:
		line_go_one += 1
	pass
