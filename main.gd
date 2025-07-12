extends Node

@export var ball_scene: PackedScene
var player_score := 0
var enemy_score := 0
var scoring = false


func _ready() -> void:
	$PlayerGoal.body_entered.connect(_on_player_goal_body_entered)
	$EnemyGoal.body_entered.connect(_on_enemy_goal_body_entered)
	$MainMenu/VBoxContainer/StartGameButton.pressed.connect(_on_start_game_button_pressed)
	$MainMenu/VBoxContainer/ExitGameButton.pressed.connect(_on_exit_game_button_pressed)

	$HUD.hide()

func _process(delta: float) -> void:
	pass

func new_game():
	$HUD/HBoxContainer/PlayerScore.text = str(0)
	$HUD/HBoxContainer/EnemyScore.text = str(0)
	
	var ball: CharacterBody2D = ball_scene.instantiate()
	add_child(ball)
	new_round()

func new_round():
	reset_positions()

func reset_positions():
	$PlayerBar.start($PlayerStartPosition.position)
	$EnemyBar.start($EnemyStartPosition.position)
	$Ball.start($BallStartPosition.position)

func _on_player_goal_body_entered(body: Node):
	if scoring:
		return

	scoring = true
	enemy_score += 1
	$HUD.update_enemy_score(enemy_score)
	scoring = false
	new_round()
	
func _on_enemy_goal_body_entered(body: Node):
	if scoring:
		return

	scoring = true
	player_score += 1
	$HUD.update_player_score(player_score)
	scoring = false
	new_round()
	
func _on_start_game_button_pressed():
	$MainMenu.hide()
	$HUD.show()
	new_game()
	
func _on_exit_game_button_pressed():
	get_tree().quit()
