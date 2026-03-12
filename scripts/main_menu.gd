extends Node

var new_game_button : TextureButton
var hi_score_button : TextureButton
var quit_button : TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		new_game_button = get_node("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/New Game Button")
		new_game_button.pressed.connect(_new_game)		
		
		hi_score_button = get_node("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Hi Scores Button")
		hi_score_button.pressed.connect(_hi_scores)
		
		quit_button = get_node("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Quit Button")
		quit_button.pressed.connect(_quit_game)

func _new_game():
	get_tree().change_scene_to_file("res://scenes/Game-Screen.tscn")
		
func _hi_scores():
	get_tree().change_scene_to_file("res://scenes/Hi-Score.tscn")

func _quit_game():
	get_tree().quit()
