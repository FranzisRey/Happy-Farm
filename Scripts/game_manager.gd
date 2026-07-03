extends Node2D

var windowToCameraRatio
var windowSize
var ifBig = true
var StoryStage = 1
@onready var label = $CanvasLayer/DialogBox/Label
@onready var dialog_box = $CanvasLayer/DialogBox
@onready var saved_player_pos:Vector2 = Vector2.INF
@onready var icon = $CanvasLayer/DialogBox/Icon
var InCutscene:bool = false
var TextSlowShowing = false
var TextShowingTime = 0
var TextShowSpeed = 1

var MinTimeLoadStart: bool = false

var scene_loading
var scene_path
# Game is 320x180 


# Called when the node enters the scene tree for the first time.
func _ready():
	$SaveLoadManager.Load()
	get_window().content_scale_size = Vector2i(320, 180)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if TextSlowShowing && InCutscene:
		TextShowingTime += 1
		if TextShowingTime >= TextShowSpeed:
			label.visible_characters += 1
			TextShowingTime = 0
		if label.visible_ratio >= 1:
			TextSlowShowing = false
	
	if scene_loading:
		
		print("yes")
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(scene_path, progress)
		print(progress[0])
		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED && $MinTimeLoad.is_stopped():
			var packed_scene = ResourceLoader.load_threaded_get(scene_path)
			get_tree().change_scene_to_packed(packed_scene)
			PlayBlackAnim(1)
			scene_path = ""
			scene_loading = false
			MinTimeLoadStart = false
			
	pass
	
	
	
	
	
	
	
	
func PlayBlackAnim(id:int):
	if id == 0:
		$CanvasLayer/BlackAnim.play("To_black")
	else:
		$CanvasLayer/BlackAnim.play("From_black")
		
# this is for doors and the minigames
func ChangeToPlace(id:int, index:int):
	if !MinTimeLoadStart:
		$MinTimeLoad.start()
		MinTimeLoadStart = true
	if id == 1:
		if index:
			saved_player_pos = Vector2(208, 192+6)
			scene_path = "res://Scenes/main_farm.tscn"
			ResourceLoader.load_threaded_request(scene_path)
			scene_loading = true
			PlayBlackAnim(0)
		else:
			scene_path = "res://Scenes/house.tscn"
			ResourceLoader.load_threaded_request(scene_path)
			scene_loading = true
			PlayBlackAnim(0)
			pass

# x is where the dialog is, y is where the dialog is
#type = 0 is no icon, type = 1 has icon
func SetDialog(text:String, ifVisible:bool, type:int, pfp:String, spd:int):
	if !TextSlowShowing:
		label.visible_characters = 0
	if ifVisible:
		TextSlowShowing = true
	TextShowSpeed = spd
	label.offset_left = type*48+16
	label.text = text
	icon.visible = type
	icon.texture = load(pfp)
	dialog_box.visible = ifVisible
	return false
