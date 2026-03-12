class_name scorecard_controller

extends Node2D

var game_conteoller : GameController
var player_name : LineEdit
var submit_score_button : Button
var results_label : RichTextLabel

var final_score : int = 0

const high_scores : String = "res://highscores.json";

func _ready():
		hide()

		game_conteoller = get_node("/root/Game Scene")
		game_conteoller.GameOver.connect(show_final)

		submit_score_button = get_node("Panel/SaveScoreButton")
		submit_score_button.pressed.connect(save_score)

		player_name = get_node("Panel/PlayerName")
		results_label = get_node("Panel/ResultsLabel")

func save_score():
	#Save high scores logic here
	var scores : Array[HiScore]
	if FileAccess.file_exists(high_scores):
		var read_file = FileAccess.open(high_scores, FileAccess.READ)
		var json = JSON.parse_string(read_file.get_as_text())
		read_file.close()
		
		if json:
			for entry in json:
				var hs = HiScore.new()	
				hs.name = entry["name"]
				hs.score = entry["score"]
				hs.timestamp = entry["timestamp"]
				scores.append(hs)
	
	var new_score = HiScore.new()
	new_score.name = player_name.text
	new_score.score = final_score
	new_score.timestamp = Time.get_unix_time_from_system()
	scores.append(new_score);

	# Save hi-scores
	var data = []
	for hs in scores:
		data.append({
			"name": hs.name,
			"score": hs.score,
			"timestamp": hs.timestamp
		})
	
	
	var write_file = FileAccess.open(high_scores, FileAccess.WRITE)
	write_file.store_string(JSON.stringify(data))
	write_file.close()

	get_tree().change_scene_to_file("res://scenes/Hi-Score.tscn");

func show_final(score : int):
	results_label.text = "You eat like a pig!\r\nScore: {0}".format([score])
	final_score = score
	show()
