extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	get_tree().get_first_node_in_group('hat_right').lift()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if Input.is_action_just_pressed('mouse_click'):
		print('start shuffle')
		get_tree().get_first_node_in_group('hat_right').drop()
		# VZTODO set shuffle count

func continue_shuffle():
	print('continue shuffle')
	get_tree().get_first_node_in_group('hat_left').shuffle()
	get_tree().get_first_node_in_group('hat_middle').shuffle()
	get_tree().get_first_node_in_group('hat_right').shuffle()

func end_shuffle():
	pass
