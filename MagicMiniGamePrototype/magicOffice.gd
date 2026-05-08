extends Node2D
@onready var game_window = $Node2D/GameWindow
@onready var hat_game = $HatGame
@onready var worksheet_window = $Node2D/WorksheetWindow
@onready var score_label = $HatGame/ScoreLabel


var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_game():
	hat_game.show()
	game_window.show()
	
	worksheet_window.hide()

func show_work():
	worksheet_window.show()
	
	game_window.hide()
	hat_game.hide()

func add_score(amount):
	score += amount
	score_label.text = str(score)

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
