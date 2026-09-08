extends Node2D
# Sickle it the rice getting wacked, im not changing the name
@onready var mouse_manager = $"Mouse Manager"
@onready var rice_getting_whacked = $"Mouse Manager/Sickle/Rice getting whacked"
@onready var _3_big = $"Mouse Manager/Sickle/3Big"
@onready var _2_big = $"Mouse Manager/Sickle/2Big"
@onready var _1_big = $"Mouse Manager/Sickle/1Big"
@onready var sickle = $"Mouse Manager/Sickle"
@onready var hit_timer = $"Mouse Manager/HitTimer"
var isHitted = false
var lastSickleVel:Vector2
var Health = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if rice_getting_whacked.frame == 0:
		_3_big.set_deferred("disabled", false)
		_2_big.set_deferred("disabled", true)
		_1_big.set_deferred("disabled", true)
	elif rice_getting_whacked.frame == 1:
		_3_big.set_deferred("disabled", true)
		_2_big.set_deferred("disabled", false)
		_1_big.set_deferred("disabled", true)
	elif rice_getting_whacked.frame == 2:
		_3_big.set_deferred("disabled", true)
		_2_big.set_deferred("disabled", true)
		_1_big.set_deferred("disabled", false)
	elif rice_getting_whacked.frame == 3:
		_3_big.set_deferred("disabled", true)
		_2_big.set_deferred("disabled", true)
		_1_big.set_deferred("disabled", true)
		
	if mouse_manager.sickle.get_colliding_bodies().size() >= 1 && !isHitted && 1000 <= sickle.linear_velocity.length() && hit_timer.is_stopped() && Health > 0:
		print(sickle.linear_velocity.length())
		hit_timer.start()
		isHitted = true
		Health =- 1
		
	
	elif mouse_manager.sickle.get_colliding_bodies().size() == 0:
		isHitted = false
	lastSickleVel = sickle.linear_velocity
	
	pass
