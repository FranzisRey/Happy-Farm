extends Node2D

@onready var sister = $Sister
@onready var check_button = $"Check Button"
@onready var area_2d = $"Check Button/Area2D"
var change_scene = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 6:
		visible = true
		sister.body.play("Right")
		sister.arm.play("Right")
		sister.hat.play("Right")
		
	else:
		sister.process_mode = Node.PROCESS_MODE_DISABLED
		visible = false
		check_button.button_mask = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.StoryStage == 6:
		sister.body.play("Right")
		sister.arm.play("Right")
		sister.hat.play("Right")
		visible = true
	elif !change_scene:
		visible = false
		sister.process_mode = Node.PROCESS_MODE_DISABLED
		
		
	if area_2d.has_overlapping_bodies() && %Player.armSprite.animation == "Left":
		check_button.visible = true
		check_button.disabled = 0
	else:
		check_button.visible = false
		check_button.disabled = 1
	pass


func _on_check_button_button_down():
	change_scene = true
	GameManager.StoryStage = 7
	GameManager.ChangeSceneNormal("res://Scenes/rice_wack_scene.tscn")
	pass # Replace with function body.
