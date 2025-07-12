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
	$MainMenu/VBoxContainer/ResetGameButton.pressed.connect(_on_reset_game_button_pressed)
	$MainMenu/VBoxContainer/ResumeGameButton.pressed.connect(_on_resume_game_button_pressed)
	
	$MainMenu.process_mode = Node.PROCESS_MODE_ALWAYS

	$HUD.hide()
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_menu"):
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		# Resume game
		get_tree().paused = false
		$MainMenu.hide()
		$HUD.show()
	else:
		# Pause game
		get_tree().paused = true
		$HUD.hide()
		$MainMenu.show()

func _process(delta: float) -> void:
	pass

func new_game():
	$MainMenu.hide()
	$HUD.show()
	get_tree().paused = false
	$HUD/HBoxContainer/PlayerScore.text = str(0)
	$HUD/HBoxContainer/EnemyScore.text = str(0)
	
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
	new_game()
	
func _on_reset_game_button_pressed():
	get_tree().paused = false 
	new_game()
	
func _on_resume_game_button_pressed():
	get_tree().paused = false
	$MainMenu.hide()
	$HUD.show()
	
func _on_exit_game_button_pressed():
	get_tree().quit()
