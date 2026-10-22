extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(.5, false).timeout
	$Black/AnimationPlayer.play("To_Clear")
	await get_tree().create_timer(3, false).timeout
	$Black/AnimationPlayer.play("To_Black")
	await get_tree().create_timer(2.5, false).timeout
	GameManager.StoryStage = 12
	GameManager.saved_player_pos = Vector2(590,163)
	GameManager.ChangeSceneNormal("res://Scenes/main_farm.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
