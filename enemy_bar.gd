extends Node2D

@export var speed := 300
var screen_size
var direction


func _ready() -> void:
	screen_size = get_viewport_rect().size
	choose_new_direction()
	
func _process(delta: float) -> void:
	var velocity := Vector2(direction * speed, 0)
	position += velocity * delta
	
	var bar_size = $ColorRect.size.x
	var max_x = Vector2(screen_size.x - bar_size, 0)
	position.x = clamp(position.x, 0, screen_size.x - $ColorRect.size.x)
	
func choose_new_direction():
	direction = 1 if randf() <= 0.5 else -1
	await get_tree().create_timer(randf_range(1.0, 2.0)).timeout
	choose_new_direction()
	
func start(pos):
	position = pos
