extends Node2D

@onready var player = %Player
@onready var sister = $Sister
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 5:
		player.hatSprite.play("Right")
		player.bodySprite.play("Right")
		player.armSprite.play("Right")
		sister.arm.play("Up")
		sister.hat.play("Up")
		sister.body.play("Up")
		GameManager.InCutscene = true
		visible = true
		
	else:
		visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
