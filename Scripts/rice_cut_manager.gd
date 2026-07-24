extends Node2D


var rice_crop
var allCut = false
signal reset
var CutTotalRank = 0
var Row = 1
var canCut = false # if can start cut
var isCutStart = false # if the cutting is started
var cutIsDone = false # if the cutting is done
var time = 0
var maxRow = 9

@onready var one_second_timer = $"OneSecond Timer"
@onready var next_row_anim = $NextRowAnim
# Called when the node enters the scene tree for the first time.
func _ready():
	
	one_second_timer.timeout.connect(TimeGoUp)
	rice_crop = preload("res://Scenes/Rice crop.tscn")
	canCut = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(CutTotalRank)
	if one_second_timer.is_stopped() && isCutStart && !cutIsDone:
		$CanvasLayer/Control/Label.visible = true
		one_second_timer.start()
	if cutIsDone && !one_second_timer.is_stopped():
		one_second_timer.stop()
		
	$CanvasLayer/Control/Label.text = "%02d:%02d" % [time/60, time%60]
	var riceInGroup = get_tree().get_nodes_in_group("Rice crop")
	var count = 0
	for i in riceInGroup:
		
		count += i.GotCut
		
	if riceInGroup.size()-count == 0:
		if !next_row_anim.is_playing() && Row <= maxRow:
			Row += 1
		elif !next_row_anim.is_playing():
			if !cutIsDone:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				print("Final Score: %d/405" % [CutTotalRank])
				var cropNumRank = max(min(ceil((float(CutTotalRank)-250) / 25) + 1, 6), 1)

				var timerNumRank = min(6 - ceil((float(time)-60) / 30), 6)
				GameManager.rice_cut_rank = cropNumRank - (6-timerNumRank)
				GameManager.StoryStage = 5
				print(cropNumRank, " ", timerNumRank)
				
			canCut = false
			cutIsDone = true
			
		if Row <= maxRow:
			next_row_anim.play("Next Row")
			if $NextRowWaitToReset.is_stopped():
				$NextRowWaitToReset.start()
			await $NextRowWaitToReset.timeout
			reset.emit()
			
func TimeGoUp():
	time += 1
