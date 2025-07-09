extends Node


func _ready() -> void:
	$PlayerBar.start($PlayerStartPosition.position)

func _process(delta: float) -> void:
	pass

func new_game():
	$PlayerBar.start($PlayerStartPosition.position)
