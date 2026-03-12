class_name PlayerController

extends Area2D

@export var Speed : int = 400

var screen_size : Vector2
var player_sprite : AnimatedSprite2D
var game_controller : GameController

var lock_controls : bool
var half_viewport : float

var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_sprite = get_node("PlayerSprite")
	game_controller = get_node("/root/Game Scene")
	
	game_controller.GameOver.connect(_lock_controls)
	
	half_viewport = (screen_size.x / 2) - 100
			
	area_entered.connect(_on_collision)
	body_entered.connect(_on_collision)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lock_controls:
		return
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
		player_sprite.flip_h = false
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
		player_sprite.flip_h = true
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * Speed
		player_sprite.play()
	else:
		player_sprite.stop()

	position += velocity * delta
	position = Vector2(clamp(position.x, 0-half_viewport, half_viewport), position.y)

func _lock_controls(_final_score: int):
	lock_controls = true

func _on_collision(body: Node2D):
	if body is BugController:
		score += body.worth
		body.queue_free()
