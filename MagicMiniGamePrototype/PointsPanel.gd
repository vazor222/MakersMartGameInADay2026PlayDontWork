extends PanelContainer
class_name PointsPanel
@export var p_name:= "You"
@export var start_score:=0
var score:= 0

@onready var rank_label = %RankLabel
@onready var name_label = %NameLabel
@onready var score_label = %ScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	name_label.text = p_name
	add_points(start_score)
	if p_name == "You":
		# 1. Get the stylebox and make it unique (important!)
		var style_box = get_theme_stylebox("panel").duplicate() as StyleBoxFlat

		# 2. Modify the color
		style_box.bg_color = Color("#b0305c") # Set to Red

		# 3. Apply the override
		add_theme_stylebox_override("panel", style_box)
		#bg_color = Color('#000000')
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_points(p):
	score += p
	score_label.text = str(score)

func update_rank(num):
	rank_label.text = "#" + str(num)
