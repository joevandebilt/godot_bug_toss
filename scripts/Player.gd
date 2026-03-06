class_name Player

extends Area2D

@export var Speed : int = 400

var screen_size : Vector2
var player_sprite : AnimatedSprite2D
var game_controller : GameController

var lock_controls : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_sprite = get_node("PlayerSprite")
	game_controller = get_node("..")
	
	#game_controller.connect(Gameover)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lock_controls:
		pass

	var velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_right"):
		velocity.X += 1
		player_sprite.flip_h = false
		
	if Input.is_action_pressed("move_left"):
		velocity.X += -1
		player_sprite.flip_h = true
		
	if velocity.len() > 0:
		velocity = velocity.normalized() * Speed
		player_sprite.play()
	else:
		player_sprite.stop()
		
	var halfX = (screen_size.x / 2) - 100
	position += velocity * delta
	position = Vector2(clamp(position.x, 0-halfX, 0+halfX), clamp(position.y, 0, screen_size.y))
	
