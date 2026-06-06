extends Node2D

@onready var pin_joint = $PinJoint
@onready var pin = $PinJoint/Pin
@onready var mango = $PinJoint/Mango
var mango_path
# Called when the node enters the scene tree for the first time.
func _ready():
	mango_path = mango.get_path()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if has_node(mango_path):
		if mango.global_position.y >= 130:
			queue_free()
			
			
		if pin.position.distance_to(mango.position) >= 3:
			print("YES")
			pin_joint.softness = 10
		else:
			pin_joint.softness = 0
			
		if pin.position.distance_to(mango.position) >= 5:
			pin_joint.node_b = NodePath("")
	else:
		queue_free()
		
	
		
	
	pass
