extends CharacterBody2D


@export var speed := 200.0
@export var ball_radius := 12
@export var ball_color := Color.WHITE
var direction


func _ready() -> void:
	print(position)
	direction = Vector2.ZERO
	direction.y = 1 if randf() <= 0.5 else -1
	direction.x = randf_range(-0.7, 0.7)

func _physics_process(delta):
	print(position)
	var velocity = direction.normalized() * speed
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var normal = collision.get_normal()
		direction = direction.bounce(normal).normalized()
	
func _draw():
	draw_circle(Vector2.ZERO, ball_radius, ball_color)
	
func start(pos):
	position = pos
