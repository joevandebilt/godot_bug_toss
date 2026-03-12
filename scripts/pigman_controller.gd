class_name PigmanController

extends Area2D

@export var Speed : int = 400

var target_x : float = 0
var min_x : float = 0
var max_x : float = 0
var moving_left : bool = false

var screen_size : Vector2
var pigman_sprite : AnimatedSprite2D
var game_controller : GameController

var bug_template : PackedScene

signal ReadyToRock

func _ready() -> void:
	bug_template = preload("res://prefab/bug.tscn")
	
	screen_size = get_viewport_rect().size
	pigman_sprite = get_node("PigmanSprite")
	game_controller = get_node("/root/Game Scene")
	
	var half_x = screen_size.x / 2 - 100
	min_x -= half_x
	max_x = half_x
	
	target_x = set_new_target()
	
	pigman_sprite.play("Standup")
	pigman_sprite.animation_finished.connect(_pigman_ready)
	
	game_controller.GameStart.connect(_start_running)
	game_controller.GameOver.connect(_stop_running)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pigman_sprite.animation != "Run":
		return
	
	if (moving_left and position.x < target_x) or (!moving_left and position.x > target_x):
		drop_bug()
		target_x = set_new_target()
		
	var velocity = Vector2.ZERO
	if target_x < position.x:
		velocity.x = -1
		pigman_sprite.flip_h = false
	else:
		velocity.x = 1
		pigman_sprite.flip_h = true
		
	position += velocity.normalized() * Speed * delta

func _pigman_ready():
	ReadyToRock.emit()
	
func _start_running():
	pigman_sprite.play("Run")
	
func _stop_running(_final_score: int):	
	pigman_sprite.animation = "Idle"
	pigman_sprite.stop()
	
func set_new_target() -> float:
	var new_target = min_x + (randf() * (screen_size.x - 100))
	moving_left = new_target < position.x
	
	print("New X Target: {0}".format([new_target]))
	return new_target
	
func drop_bug():
	var new_bug = bug_template.instantiate()
	new_bug.global_position = global_position
	game_controller.add_child(new_bug)
	
