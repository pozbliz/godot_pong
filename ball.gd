extends CharacterBody2D


@export var speed := 250.0
@export var speed_increase := 5.0  # in %
@export var ball_radius := 12
@export var ball_color := Color.WHITE
var direction
var game_started := false


func _ready() -> void:
	direction = Vector2.ZERO

func _physics_process(delta):
	if not game_started:
		return

	var velocity = direction.normalized() * speed
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var normal = collision.get_normal()
		direction = direction.bounce(normal).normalized()
		
		var increase_factor: float = 1 + speed_increase / 100
		speed = speed * increase_factor
	
func _draw():
	draw_circle(Vector2.ZERO, ball_radius, ball_color)

func start(pos):
	position = pos
	speed = 250
	game_started = true
	direction.y = 1 if randf() <= 0.5 else -1
	direction.x = randf_range(-0.7, 0.7)
	
	await get_tree().create_timer(1).timeout
