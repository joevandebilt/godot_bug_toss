class_name BugController

extends Area2D

var speed : int
var type : int
var worth : int

signal BugCollected (worth)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_scale(Vector2(2, 2))
	
	var sprite = AnimatedSprite2D.new()
	sprite.SpriteFrames = load("res://sprites/bug_animations.tes")

	match (randi_range(1, 10)):
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
			
	print("Bug type: %s" % type)		
	match (type):
		1:
			worth = 5
		2:
			worth = 10
		3: 
			worth = 15
		4:
			worth = 30
		_: 
			worth = 5
	
	speed = randi_range(100, 300)
	sprite.animation = "bug_%s" % type
	
	add_child(sprite)
	sprite.play()
	
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 17
	collision.shape = shape
	add_child(collision)
	
	area_entered.connect(_on_collision)
	body_entered.connect(_on_collision)
	
func _on_collision(body: Node2D):
	if body is Player:
		print("Collided with player! Adding %s points!" % worth)
		emit_signal("BugCollected", worth)
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position 
