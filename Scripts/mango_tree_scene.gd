extends Node2D

var mangoNode
@onready var mango_picker = $"Mango picker"

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0).timeout
	get_viewport().warp_mouse(get_viewport().size/5)
	
	mangoNode = preload("res://Scenes/mango.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_global_mouse_position()
	
	if get_tree().get_node_count_in_group("Mango") <= 0:
		for i in range(10):
			var mangoIn = mangoNode.instantiate()
			mangoIn.position.x = randf_range(-100, 100)
			mangoIn.position.y = randf_range(-60, 0)
			add_child(mangoIn)
	
	
	mango_picker.position = mousePos
	for i in$"Basket/Mango Detector".get_overlapping_bodies():
		i.queue_free()
	
	pass
