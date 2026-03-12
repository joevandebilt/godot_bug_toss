class_name GameController

extends Node2D

var pigman : PigmanController
var player : PlayerController

var time_label : Label
var score_label : Label
var game_timer : Timer

var time_remaining : int = 30
var score : int = 0

signal GameStart
signal GameOver(final_score)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("Player")
	
	pigman = get_node("Pigman")
	pigman.ReadyToRock.connect(start_game)	
	
	time_label = get_node("TimeLabel")
	score_label = get_node("ScoreLabel")
	game_timer = get_node("Timer")

func _process(_delta: float) -> void:
	time_label.text = "Time Remaining: {0}".format([round(game_timer.time_left)])
	score_label.text = "Score: {0}".format([player.score])

func start_game():
	GameStart.emit()
	game_timer.start(time_remaining)
	game_timer.timeout.connect(end_game)
	
func end_game():
	var score = player.score
	game_timer.stop()
	GameOver.emit(score)
