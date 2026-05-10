extends Node2D
@onready var game_window = %GameWindow
@onready var hat_game = $HatGame
@onready var worksheet_window = %WorksheetWindow
@onready var progress_bar = $ProgressBar
@onready var lose_label = $LoseLabel
@onready var player_points_panel = %PlayerPointsPanel
@onready var rival_points_panel_a = %RivalPointsPanelA
@onready var rival_points_panel_b = %RivalPointsPanelB
@onready var points_panels_v_box = %PointsPanelsVBox
@onready var rival_timer_a = %RivalTimerA
@onready var rival_timer_b = %RivalTimerB
@onready var boss = %Boss

var suspicion = 0
var boss_on_screen = false
var is_working = false
var game_over = false

var rival_times_a = [5,6,7,8]
var rival_times_b = [6,7,8,10]

var dark = preload("res://assets/work-window-dark-Sheet.png")
	
var light = preload("res://assets/work-window-Sheet.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	sort_scores()
	show_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over:
		return
	if boss_on_screen and !is_working:
		if game_window.visible:
			add_suspicion(delta * 30)
		else:
			add_suspicion(delta * 5)
	else:
		add_suspicion(-delta * 1)
	pass

func show_game():
	is_working = false
	hat_game.show()
	game_window.show()
	hide_work()

func show_work():
	is_working = true
	worksheet_window.show()
	hide_game()

func hide_game():
	game_window.hide()
	hat_game.hide()
	get_tree().call_group('cell', 'deactivate')

func hide_work():
	is_working = false
	worksheet_window.hide()

func add_suspicion(amount):
	if game_over:
		return
	suspicion += amount
	if suspicion < 0:
		suspicion = 0
	elif suspicion > progress_bar.max_value:
		suspicion = progress_bar.max_value
		print("you LOOSE")
		lose_label.show()
		boss.stop()
		game_over = true
	progress_bar.value = suspicion

func add_score(amount):
	player_points_panel.add_points(amount)
	sort_scores()

func add_rival_score(target, points):
	target.add_points(points)
	sort_scores()

func sort_scores():
	var panels = points_panels_v_box.get_children()
	panels.sort_custom(func(a, b): return a.score > b.score)
	for i in panels.size():
		points_panels_v_box.move_child(panels[i], i)
		panels[i].update_rank(i + 1)

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


func work_dark():
	%WorksheetWindow.texture = dark
	get_tree().call_group('cell', 'light_text')
	
func work_light():
	%WorksheetWindow.texture = light
	get_tree().call_group('cell', 'dark_text')

func get_rival_wait_time(arr):
	var new_time = arr[randi() % arr.size()]
	print('NEW TIME:', new_time)
	return new_time

func _on_rival_timer_a_timeout():
	print('TIMEOUTA')
	add_rival_score(rival_points_panel_a, 1)
	rival_timer_a.wait_time = get_rival_wait_time(rival_times_a)
	rival_timer_a.start()
	pass # Replace with function body.


func _on_rival_timer_b_timeout():
	print('TIMEOUTB')
	add_rival_score(rival_points_panel_b, 1)
	rival_timer_b.wait_time = get_rival_wait_time(rival_times_b)
	rival_timer_b.start()
	pass # Replace with function body.


func _on_replay_button_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.
