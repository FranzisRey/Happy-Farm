extends Node2D

@onready var mouse_pos = $"../Mouse Manager/MousePos"
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.GotUnpaused.connect(Unpausing)
	GameManager.GotPaused.connect(Pausing)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
func Unpausing():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	get_viewport().warp_mouse(mouse_pos.global_position+Vector2(160,90))
func Pausing():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
