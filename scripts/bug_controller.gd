class_name BugController

extends Area2D

var speed : int = 0
var type : int = 0
var worth : int = 0

var sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng = randi_range(1, 11)
	match rng:
		1, 2, 3, 4:
			type = 1
		5, 6, 7:
			type = 2
		8, 9:
			type = 3
		10: 
			type = 4
		_:
			type = 1
			
	print("Bug type: {0}".format([type]))
	speed = randi_range(100, 300)
	
	sprite = get_node("BugSprite")
	sprite.play("bug_{0}".format([type]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2.DOWN * speed * delta
	if position.y > get_viewport_rect().size.y:
		queue_free()
