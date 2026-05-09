extends Node2D
@onready var game_window = $Node2D/GameWindow
@onready var hat_game = $HatGame
@onready var worksheet_window = $Node2D/WorksheetWindow
@onready var score_label = $HatGame/ScoreLabel
@onready var progress_bar = $ProgressBar
@onready var lose_label = $LoseLabel


var score = 0
var suspicion = 0
var boss_on_screen = false
var playing_game = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
	if boss_on_screen and playing_game:
		suspicion += delta * 30
	else:
		suspicion -= delta * 10
	if suspicion < 0:
		suspicion = 0
	elif suspicion > 100:
		suspicion = 100
		print("you LOOSE")
		lose_label.show()
	progress_bar.value = suspicion
	pass

func show_game():
	playing_game = true
	hat_game.show()
	game_window.show()
	
	worksheet_window.hide()

func show_work():
	playing_game = false
	worksheet_window.show()
	
	game_window.hide()
	hat_game.hide()

func add_score(amount):
	score += amount
	score_label.text = str(score)


func _on_visible_on_screen_notifier_2d_screen_entered():
	boss_on_screen = true
	print("on screen")
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	boss_on_screen = false
	print("off screen")
	pass # Replace with function body.
func clicked_hat_index(index):
	var highestMoveCount:int = 0
	var leftMoveCount = get_tree().get_first_node_in_group('hat_left').get_move_count()
	if leftMoveCount > highestMoveCount:
		highestMoveCount = leftMoveCount
	var middleMoveCount = get_tree().get_first_node_in_group('hat_middle').get_move_count()
	if middleMoveCount > highestMoveCount:
		highestMoveCount = middleMoveCount
	var rightMoveCount = get_tree().get_first_node_in_group('hat_right').get_move_count()
	if rightMoveCount > highestMoveCount:
		highestMoveCount = rightMoveCount
	
	if index == 0 && leftMoveCount == highestMoveCount:
		add_score(1)
	elif index == 1 && middleMoveCount == highestMoveCount:
		add_score(1)
	elif index == 2 && rightMoveCount == highestMoveCount:
		add_score(1)
	
	pass
