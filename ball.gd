extends CharacterBody2D


@onready var direction: Vector2 = Vector2.ZERO
@export var speed := 250.0
var game_started := false

const SPEED_INCREASE := 5.0  # in %
const MAX_SPEED := 500
const BALL_RADIUS := 12
const BALL_COLOR := Color.WHITE


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _physics_process(delta):
	if not game_started:
		return

	var velocity = direction.normalized() * speed
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var normal = collision.get_normal()
		direction = direction.bounce(normal).normalized()
		
		var increase_factor: float = 1 + SPEED_INCREASE / 100
		speed = min(speed * increase_factor, MAX_SPEED)
	
func _draw():
	draw_circle(Vector2.ZERO, BALL_RADIUS, BALL_COLOR)

func start(pos):
	position = pos
	speed = 250
	game_started = true
	direction.y = 1 if randf() <= 0.5 else -1
	direction.x = randf_range(-0.7, 0.7)
	
	await get_tree().create_timer(1).timeout
