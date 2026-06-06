extends Node2D

var eggNode
# Called when the node enters the scene tree for the first time.
func _ready():
	eggNode = preload("res://Scenes/egg.tscn")
	var randCount = randi_range(0,3)
	var i = 1
	while(i <= randCount && randCount != 0):
		var eggIn = eggNode.instantiate()
		eggIn.position.y = -5
		eggIn.z_index = -1
		if randCount != 1:
			eggIn.position.x = (-5*(randCount-1))+(10*(i-1))
			add_child(eggIn)
		else:
			add_child(eggIn)
			
		i += 1
		pass
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
