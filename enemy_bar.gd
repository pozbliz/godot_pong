extends Node2D

@export var speed := 250
@export var smoothing := 5.0
var screen_size
var direction
var ball: CharacterBody2D


func _ready() -> void:
	screen_size = get_viewport_rect().size
	ball = get_node("../Ball")
	
func _process(delta: float) -> void:
	var target_x = ball.position.x
	
	if ball.direction.y < 0:
		position.x = lerp(position.x, target_x, smoothing * delta)
		position.x = clamp(position.x, 0, screen_size.x - $ColorRect.size.x)
	
func start(pos):
	position = pos
