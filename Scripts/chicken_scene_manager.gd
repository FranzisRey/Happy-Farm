extends Node2D
@onready var BasketChecker = $Basket/Area2D
@onready var done_button = $"Done Button"
@onready var restart_button = $"Restart Button"
var eggCount = 0
var totalInBasket
var totalOnScreen
# Called when the node enters the scene tree for the first time.
func _ready():
	eggCount = get_tree().get_node_count_in_group("Egg")
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	totalInBasket = BasketChecker.get_overlapping_bodies().size()
	totalOnScreen = get_tree().get_node_count_in_group("Egg")
	print(eggCount, " ", totalInBasket, " ", totalOnScreen)
	if totalOnScreen <= eggCount - 3:
		restart_button.visible = true
		restart_button.disabled = false
	else:
		restart_button.visible = false
		restart_button.disabled = true
		if totalInBasket >= eggCount - 2:
			done_button.visible = true
			done_button.disabled = false
		else:
			done_button.visible = false
			done_button.disabled = true
	
	
	
	
	pass


func _on_done_button_pressed():
	GameManager.StoryStage = 11
	GameManager.ChangeSceneNormal("res://Scenes/Chicken feed.tscn")
	pass # Replace with function body.


func _on_restart_button_pressed():
	GameManager.ResetScene()
	pass # Replace with function body.
