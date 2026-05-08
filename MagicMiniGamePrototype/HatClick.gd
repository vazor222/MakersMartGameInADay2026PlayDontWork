extends Area2D

@export var index:int
@export var shuffle_count:int
@export var has_rabbit:bool
@export var animation_player:AnimationPlayer

var shuffle_count_current:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	if index != 2:
		$BunnySprite2D.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if Input.is_action_just_pressed('mouse_click'):
		print('clicked! idx:', index)

func _on_drop_finished():
	get_tree().get_first_node_in_group('start_shuffle').continue_shuffle()
	$BunnySprite2D.hide()

func lift():
	animation_player.play('hat_lift_up')

func drop():
	animation_player.play('hat_drop_down')

func start_shuffle():
	shuffle_count_current = shuffle_count

func shuffle():
	if shuffle_count_current > 0:
		shuffle_count_current -= 1
	
	if shuffle_count_current == 0:
		if index == 0:
			end_shuffle()
		pass
	
	var target_pos:int = randi() % 3
	print('shuffle index:',index,' target_pos:',target_pos)
	if index == 0:
		if target_pos == 1:
			animation_player.play('hat_shuffle_left_to_middle')
		elif target_pos == 2:
			animation_player.play('hat_shuffle_left_to_right')
	elif index == 1:
		if target_pos == 0:
			animation_player.play('hat_shuffle_middle_to_left')
		elif target_pos == 2:
			animation_player.play('hat_shuffle_middle_to_right')
	elif index == 2:
		if target_pos == 0:
			animation_player.play('hat_shuffle_right_to_left')
		elif target_pos == 1:
			animation_player.play('hat_shuffle_right_to_middle')

func end_shuffle():
	get_tree().get_first_node_in_group('start_shuffle').end_shuffle()
