extends Node2D

@onready var area_2d = $House/Area2D
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.PlayBlackAnim(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if area_2d.has_overlapping_bodies():
		GameManager.ChangeToPlace(1,0)
	pass
