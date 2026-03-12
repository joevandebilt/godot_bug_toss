class_name scorecard_controller

extends Node2D

var game_conteoller : GameController
var player_name : LineEdit
var submit_score_button : Button
var results_label : RichTextLabel

var final_score : int = 0

const high_scores : String = "highscores.txt";

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
	var scores : Array[String]
	var file_access = FileAccess.new()
	if FileAccess.file_exists(high_scores):
		file_access.open(high_scores, FileAccess.READ_WRITE)
				
		var checksum = file_access.get_line()
		var content = file_access.get_as_text()
			
		if checksum.length():
			if content.md5_text() != checksum:
				content = ""
			
			
		if (scores.Any())
		{
			var checksum = scores.First();
			var checked_checksum = Md5Extensions.GetMd5Checksum(scores);

			if (checked_checksum != checksum)
			{
				File.Copy(highscores, $"{highscores}_{checked_checksum}");
				scores = new List<string>();
			}
		}
	}
	scores.append($"{0},{1},{2}".format([player_name, final_score, ]));

	var new_checksum = Md5Extensions.GetMd5Checksum(scores);

	file_access.store_string(scores)

	file_access.close()

	get_tree().change_scene_to_file("res://scenes/Hi-Score.tscn");

func show_final(score : int):
	results_label.text = "You eat like a pig!\r\nScore: {0}".format([score])
	final_score = score
	show()
