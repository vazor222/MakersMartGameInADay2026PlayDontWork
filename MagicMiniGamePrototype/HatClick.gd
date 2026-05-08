extends Area2D

@export var index:int
@export var has_rabbit:bool
@export var animation_player:AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if Input.is_action_just_pressed('mouse_click'):
		print('clicked! idx:', index)

func lift():
	animation_player.play('hat_lift_up')

func drop():
	animation_player.play('hat_drop_down')

func shuffle():
	var target_pos:int = randi() % 3
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
