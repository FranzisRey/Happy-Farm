extends Node2D

var banana
var windForce:Vector2
var windDir
@onready var banana_left_pin = $BananaLeftPin
@onready var banana_right_pin = $BananaRightPin
# Called when the node enters the scene tree for the first time.
func _ready():
	banana = preload("res://Scenes/banana.tscn")
	
	var bananaIn1 = banana.instantiate()
	
	banana_left_pin.add_child(bananaIn1)
	banana_left_pin.node_b = bananaIn1.get_path()
	
	var bananaIn2 = banana.instantiate()
	
	
	
	banana_right_pin.add_child(bananaIn2)
	banana_right_pin.node_b = bananaIn2.get_path()
	
	bananaIn2.get_node(bananaIn2.get_path()).banana_reduced.flip_v = true
	bananaIn2.get_node(bananaIn2.get_path()).banana_reduced.rotation = -PI/2
	
	
	windForce = Vector2(randf_range(400,600), 0)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#wind
	var theBananas = get_tree().get_nodes_in_group("Banana")
	print(windForce)
	for i in theBananas:
		i.apply_force(windForce, Vector2(0,17))
	pass


func _on_wind_timeout():
	var lastWindDir = windDir
	while(windDir == lastWindDir):
		windDir = randi_range(-1, 1)
		print(windDir)
	windForce = Vector2(randf_range(200,400)*windDir, 0)
	pass # Replace with function body.
