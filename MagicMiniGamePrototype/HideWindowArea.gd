extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if Input.is_action_just_pressed('mouse_click'):
		get_tree().get_first_node_in_group('magic_office').hide_work()
		get_tree().get_first_node_in_group('magic_office').hide_game()
