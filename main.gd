extends Node


func _ready() -> void:
	$PlayerBar.start($PlayerStartPosition.position)
	$EnemyBar.start($EnemyStartPosition.position)
	$Ball.start($BallStartPosition.position)

func _process(delta: float) -> void:
	pass

func new_game():
	$PlayerBar.start($PlayerStartPosition.position)
	$EnemyBar.start($EnemyStartPosition.position)
	$Ball.start($BallStartPosition.position)
