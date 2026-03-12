class_name HiScoreController

extends Control

var high_scores : String = "res://highscores.json"
var high_score_table : RichTextLabel
var return_button : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score_table = get_node("MarginContainer/VBoxContainer/HighScores")
	
	return_button = get_node("MarginContainer/VBoxContainer/ReturnButton")
	return_button.pressed.connect(_return_to_main_menu)
	
	_load_high_scores()

func _return_to_main_menu():
	get_tree().change_scene_to_file("res://scenes/Main-Menu.tscn")

func _load_high_scores():
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
				
	scores.sort_custom(scores_descending)
	var scoreboard_text = "[table=3][cell][b]Score[/b][/cell][cell padding=100,0,100,0][b]Player[/b][/cell][cell][b]Time[/b][/cell]"
	for entry in scores:
		scoreboard_text += "[cell]{0}[/cell][cell padding=100,0,100,0]{1}[/cell][cell]{2} days ago[/cell]".format([
			entry.name,
			entry.score,
			days_since(entry.timestamp)
		])	
	scoreboard_text += "[/table]"
	
	high_score_table.text = scoreboard_text

func scores_descending(a:HiScore, b:HiScore):
	if a.score > b.score:
		return true
	return false

func days_since(unix_timestamp: int) -> int:
	var now = Time.get_unix_time_from_system()
	var seconds_elapsed = now - unix_timestamp
	return int(seconds_elapsed / (60 * 60 * 24))
