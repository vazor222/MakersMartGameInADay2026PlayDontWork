@tool
extends Area2D

var active = false
@onready var label = $MarginContainer/Label
@onready var select_frame = %SelectFrame
@export var text := "Credit":
	set(value):
		text = value
		if is_node_ready():
			label.text = text
@export var start_shown = true:
	set(value):
		start_shown = value
		if is_node_ready():
			label.visible = start_shown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		input_event.connect(_on_input_event)
	label.text = text
	label.visible = start_shown

func clear():
	label.visible = false

func light_text():
	label.add_theme_color_override("font_color", Color("#ffffeb"))
	
func dark_text():
	label.add_theme_color_override("font_color", Color("#272736"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func deactivate():
	active = false
	select_frame.visible = false

func _on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int):
	if Input.is_action_just_pressed('mouse_click'):
		active = true
		get_tree().call_group('cell', 'deactivate')
		select_frame.visible = true
		label.visible = !label.visible
		get_tree().get_first_node_in_group('magic_office').add_suspicion(-2)
