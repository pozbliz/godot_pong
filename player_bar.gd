extends Node2D

@export var speed := 200
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func _process(delta: float) -> void:
	var velocity := Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1 * speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1 * speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
func start(pos):
	position = pos
