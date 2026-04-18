extends Node2D

@onready var pin_joint = $PinJoint
@onready var pin = $PinJoint/Pin
@onready var mango = $PinJoint/Mango

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pin.position.distance_to(mango.position) >= 10:
		print(pin.position.distance_to(mango.position))
		pin_joint.node_b = NodePath("")
	pass
