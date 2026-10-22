extends Node2D

@onready var go_inside_button = $"Go Inside"
@onready var area_2d = $"Go Inside/Area2D"
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 9:
		visible = true
	else:
		go_inside_button.disabled = true
		visible = false
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.StoryStage == 9:
		visible = true
	else:
		go_inside_button.disabled = true
		visible = false
		
	if area_2d.has_overlapping_bodies():
		go_inside_button.visible = true
		go_inside_button.disabled = false
	else:
		go_inside_button.visible = false
		go_inside_button.disabled = true
	pass


func _on_go_inside_pressed():
	GameManager.StoryStage = 10
	GameManager.ChangeSceneNormal("res://Scenes/chicken_scene.tscn")
	pass # Replace with function body.
