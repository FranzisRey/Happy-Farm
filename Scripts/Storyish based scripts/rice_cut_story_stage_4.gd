extends Node2D


var diaStage = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.StoryStage == 4:
		await get_tree().create_timer(1).timeout
		diaStage = 1
		GameManager.InCutscene = true
		$Label.visible = true
		GameManager.SetDialog("Wag mong masyadong itaas ang pag-aani ha.", true, 0, "", 3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if diaStage != -1:
		if Input.is_action_just_pressed("LMB") && !GameManager.TextSlowShowing:
			diaStage += 1
			match diaStage:
				2:
					GameManager.SetDialog("Oo, alam ko pa naman kung anong gagawin ko dine.", true, 0, "", 2)
				3:
					GameManager.SetDialog("Tinutulungan na nga at lahat >:(", true, 0, "", 3)
				4:
					$Label.visible = false
					GameManager.InCutscene = false
					diaStage = -1
					GameManager.SetDialog()
					pass
			
	pass
