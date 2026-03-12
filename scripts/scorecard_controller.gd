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

		game_conteoller = get_node("/root/Game Scene");
		game_conteoller.GameOver.connect(show_final);

		submit_score_button = get_node("Panel/SaveScoreButton")
		submit_score_button.pressed.connect(save_score)

		player_name = get_node("Panel/PlayerName")
		results_label = get_node("Panel/ResultsLabel")

func save_score():
	#//Save high scores logic here
	#var scores = new List<string>();
	#if (File.Exists(highscores))
	#{
		#using var reader = new StreamReader(highscores);
		#scores = reader.ReadToEnd().Split('\n', StringSplitOptions.TrimEntries | StringSplitOptions.RemoveEmptyEntries).ToList();
		#if (scores.Any())
		#{
			#var checksum = scores.First();
			#var checked_checksum = Md5Extensions.GetMd5Checksum(scores);
#
			#if (checked_checksum != checksum)
			#{
				#File.Copy(highscores, $"{highscores}_{checked_checksum}");
				#scores = new List<string>();
			#}
#
			#scores.RemoveAt(0);
		#}
	#}
	#scores.Add($"{playerName.Text},{finalScore},{DateTime.Now.Ticks}");
#
	#var new_checksum = Md5Extensions.GetMd5Checksum(scores);
#
	#using (var writer = new StreamWriter(highscores, append: false))
	#{
		#writer.WriteLine(new_checksum);
		#scores.ForEach(s => writer.WriteLine(s));
	#}

	get_tree().change_scene_to_file("res://scenes/Hi-Score.tscn");

func show_final(score : int):
	results_label.text = "You eat like a pig!\r\nScore: {0}".format([score])
	final_score = score
	show()
