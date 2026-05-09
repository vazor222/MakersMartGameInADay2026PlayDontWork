extends Sprite2D
@onready var animation_player = $AnimationPlayer

func _ready():
	pass

# func _process(delta):
# 	pass

func _on_animation_player_animation_finished(anim_name):
	var animations = animation_player.get_animation_list()
	animation_player.play(animations[randi() % animations.size()])
	pass # Replace with function body.
