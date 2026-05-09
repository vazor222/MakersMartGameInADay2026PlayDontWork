extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int):
	if Input.is_action_just_pressed('mouse_click'):
		$AnimationPlayer.play('click')
		get_tree().call_group('cell', 'deactivate')
		get_tree().call_group('cell', 'clear')
		get_tree().get_first_node_in_group('magic_office').add_suspicion(-2)
