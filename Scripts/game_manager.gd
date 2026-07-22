extends Node2D

var windowToCameraRatio
var windowSize

var ifBig = true
var StoryStage = -1
var rice_cut_rank = -1

@onready var label = $CanvasLayer/DialogBox/Label
@onready var dialog_box = $CanvasLayer/DialogBox
@onready var saved_player_pos:Vector2 = Vector2.INF
@onready var icon = $CanvasLayer/DialogBox/Icon
var InCutscene:bool = false
var TextSlowShowing = false
var TextShowingTime = 0
var TextShowSpeed = 1
signal TextIsFinsihed
var ifFadedIn = true
var MinTimeLoadStart: bool = false




var scene_loading
var scene_path
# Game is 320x180 
#player faces
const _1_player_calm_nohat = "res://Sprites/Player png faces/1Player_Calm(nohat).png"
const _1_player_calm = "res://Sprites/Player png faces/1Player_Calm.png"
const _2_player_confused_nohat = "res://Sprites/Player png faces/2Player_Confused(nohat).png"
const _2_player_confused = "res://Sprites/Player png faces/2Player_Confused.png"
const _3_player_angry_nohat = "res://Sprites/Player png faces/3Player_Angry(nohat).png"
const _3_player_angry = "res://Sprites/Player png faces/3Player_Angry.png"
const _4_player_annoyed_nohat = "res://Sprites/Player png faces/4Player_Annoyed(nohat).png"
const _4_player_annoyed = "res://Sprites/Player png faces/4Player_Annoyed.png"
const _5_player_sad_nohat = "res://Sprites/Player png faces/5Player_Sad(nohat).png"
const _5_player_sad = "res://Sprites/Player png faces/5Player_Sad.png"
const _6_player_joyful_nohat = "res://Sprites/Player png faces/6Player_Joyfu(nohat)l.png"
const _6_player_joyful = "res://Sprites/Player png faces/6Player_Joyful.png"
const _7_player_smug_nohat = "res://Sprites/Player png faces/7Player_Smug(nohat).png"
const _7_player_smug = "res://Sprites/Player png faces/7Player_Smug.png"
const _8_player_stupidface_nohat = "res://Sprites/Player png faces/8Player_stupidface(nohat).png"
const _8_player_stupidface = "res://Sprites/Player png faces/8Player_stupidface.png"
#sister faces
const _1_sister_calm_nohat = "res://Sprites/Sister png faces/1SisterEllia_Calm(nohat).png"
const _1_sister_calm = "res://Sprites/Sister png faces/1SisterEllia_Calm.png"
const _2_sister_confused_nohat = "res://Sprites/Sister png faces/2SisterEllia_Confusednohat).png"
const _3_sister_angry_nohat = "res://Sprites/Sister png faces/3SisterEllia_Angry(nohat).png"
const _2_sister_confused = "res://Sprites/Sister png faces/2SisterEllia_Confused.png"
const _3_sister_angry = "res://Sprites/Sister png faces/3SisterEllia_Angry.png"
const _4_sister_annoyed_nohat = "res://Sprites/Sister png faces/4SisterEllia_Annoyed(nohat).png"
const _4_sister_annoyed = "res://Sprites/Sister png faces/4SisterEllia_Annoyed.png"
const _5_sister_sad_nohat = "res://Sprites/Sister png faces/5SisterEllia_Sad(nohat).png"
const _5_sister_sad = "res://Sprites/Sister png faces/5SisterEllia_Sad.png"
const _6_sister_joyful_nohat = "res://Sprites/Sister png faces/6SisterEllia_Joyful(nohat).png"
const _6_sister_joyful = "res://Sprites/Sister png faces/6SisterEllia_Joyful.png"
const _7_sister_smug_nohat = "res://Sprites/Sister png faces/7SisterEllia_Smug(nohat).png"
const _7_sister_smug = "res://Sprites/Sister png faces/7SisterEllia_Smug.png"
# dad faces
const _1_dad_calm_nohat = "res://Sprites/Father png faces/1Father_Calm(nohat).png"
const _1_dad_calm = "res://Sprites/Father png faces/1Father_Calm.png"
const _2_dad_confused_nohat = "res://Sprites/Father png faces/2Father_Confused(nohat).png"
const _2_dad_confused = "res://Sprites/Father png faces/2Father_Confused.png"
const _3_dad_angry_nohat = "res://Sprites/Father png faces/3Father_Angry(nohat).png"
const _3_dad_angry = "res://Sprites/Father png faces/3Father_Angry.png"
const _5_dad_sad_nohat = "res://Sprites/Father png faces/5Father_Sad(nohat).png"
const _5_dad_sad = "res://Sprites/Father png faces/5Father_Sad.png"
const _6_dad_joyful_nohat = "res://Sprites/Father png faces/6Father_Joyful(nohat).png"
const _6_dad_joyful = "res://Sprites/Father png faces/6Father_Joyful.png"
# Called when the node enters the scene tree for the first time.
func _ready():
	saved_player_pos = Vector2.INF
	$SaveLoadManager.Load()
	get_window().content_scale_size = Vector2i(320, 180)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	
	
	
	
	
	
	if Input.is_action_just_pressed("F11") && get_window().mode == Window.MODE_FULLSCREEN:
		get_window().mode = Window.MODE_WINDOWED
	elif Input.is_action_just_pressed("F11"):
		get_window().mode = Window.MODE_FULLSCREEN
	
	if TextSlowShowing && InCutscene:
		if $WhenComma.is_stopped():
			TextShowingTime += 1
		if TextShowingTime >= TextShowSpeed:
			label.visible_characters += 1
			TextShowingTime = 0
			if label.text[label.visible_characters-1] == ",":
				$WhenComma.start()
		if label.visible_ratio >= 1:
			TextIsFinsihed.emit()
			TextSlowShowing = false
			
		if TextShowSpeed == -1:
			label.visible_ratio = 1
			TextSlowShowing = false
	
	if scene_loading:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(scene_path, progress)
		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED && $MinTimeLoad.is_stopped():
			var packed_scene = ResourceLoader.load_threaded_get(scene_path)
			get_tree().change_scene_to_packed(packed_scene)
			if ifFadedIn:
				PlayBlackAnim(1)
			elif !ifFadedIn:
				ifFadedIn = false
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
			saved_player_pos = Vector2(288, 175)
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
			
func ChangeSceneNormal(path:String, ifFadeIn:bool = true):
	ifFadedIn = ifFadeIn
	if !MinTimeLoadStart:
		$MinTimeLoad.start()
		MinTimeLoadStart = true
	scene_path = path
	ResourceLoader.load_threaded_request(scene_path)
	scene_loading = true
	PlayBlackAnim(0)

# x is where the dialog is, y is where the dialog is
#type = 0 is no icon, type = 1 has icon
func SetDialog(text:String = "", ifVisible:bool = false, type:int = 0, pfp:String = "", spd:int = -1):
	
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
