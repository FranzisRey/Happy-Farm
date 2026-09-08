extends Node2D

@onready var mouse_pos = $MousePos
@onready var sickle = $Sickle
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	get_viewport().warp_mouse(Vector2(160,90))
	$Sickle.freeze = false
	pass # Replace with function body.

func _physics_process(delta):
	mouse_pos.global_position = get_global_mouse_position()
	var direction: Vector2 = mouse_pos.global_position - sickle.global_position
	var distance: float = direction.length()
	direction = direction.normalized()
	sickle.linear_velocity =  distance * direction * 1500 * delta
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sickle.get_contact_count() >= 1:
		mouse_pos.position = sickle.position
		get_viewport().warp_mouse(mouse_pos.global_position+Vector2(160,90))

	
	pass
