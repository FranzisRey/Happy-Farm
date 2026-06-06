extends Node2D

var windowToCameraRatio
var windowSize
var ifBig = true
@onready var label = $CanvasLayer/DialogBox/Label
@onready var dialog_box = $CanvasLayer/DialogBox

# Game is 320x180 
# Called when the node enters the scene tree for the first time.
func _ready():
	get_window().content_scale_size = Vector2i(320, 180)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	pass

# x is where the dialog is, y is where the dialog is
func SetDialog(text, ifVisible):
	label.text = text
	dialog_box.visible = ifVisible
	return false
	
