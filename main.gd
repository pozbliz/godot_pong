extends Node


var player_score := 0
var enemy_score := 0
var scoring = false

func _ready() -> void:
	$PlayerBar.start($PlayerStartPosition.position)
	$EnemyBar.start($EnemyStartPosition.position)
	$Ball.start($BallStartPosition.position)
	$HUD/HBoxContainer/PlayerScore.text = str(0)
	$HUD/HBoxContainer/EnemyScore.text = str(0)
	
	$PlayerGoal.body_entered.connect(_on_player_goal_body_entered)
	$EnemyGoal.body_entered.connect(_on_enemy_goal_body_entered)

func _process(delta: float) -> void:
	pass

func new_game():
	reset_positions()
	$HUD/HBoxContainer/PlayerScore.text = 0
	$HUD/HBoxContainer/EnemyScore.text = 0
	
func reset_positions():
	$Ball.start($BallStartPosition.position)
	$PlayerBar.start($PlayerStartPosition.position)
	$EnemyBar.start($EnemyStartPosition.position)

func _on_player_goal_body_entered(body: Node):
	if scoring:
		return
	
	print("Player Goal")
	scoring = true
	enemy_score += 1
	$HUD.update_enemy_score(enemy_score)
	reset_positions()
	scoring = false
	
func _on_enemy_goal_body_entered(body: Node):
	if scoring:
		return
	
	print("Enemy Goal")
	scoring = true
	player_score += 1
	$HUD.update_player_score(player_score)
	reset_positions()
	scoring = false
