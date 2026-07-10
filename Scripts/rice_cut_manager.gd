extends Node2D


var rice_crop
var allCut = false
signal reset
var CutTotalRank = 0
var Row = 1
@onready var next_row_anim = $NextRowAnim
# Called when the node enters the scene tree for the first time.
func _ready():
	rice_crop = preload("res://Scenes/Rice crop.tscn")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var riceInGroup = get_tree().get_nodes_in_group("Rice crop")
	var count = 0
	print(Row)
	for i in riceInGroup:
		
		count += i.GotCut
		
	if riceInGroup.size()-count == 0:
		if !next_row_anim.is_playing() && Row <= 10:
			Row += 1
		if Row <= 10:
			next_row_anim.play("Next Row")
			await get_tree().create_timer(.25).timeout
			reset.emit()
			
			
	
	
