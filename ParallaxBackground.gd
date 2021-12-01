extends ParallaxBackground

func _ready():
	normal(null)

func normal(body):
	get_node("Sky/Sprite").set_self_modulate(Color(1, 1, 1))
	get_node("Far/Sprite").set_self_modulate(Color(0.882353, 0.839216, 0.156863, 0.65098))
	get_node("Middle/Sprite").set_self_modulate(Color(0.733333, 0.580392, 0.086275, 0.643137))
	get_node("Near/Sprite").set_self_modulate(Color(0.584314, 0.572549, 0.266667, 0.615686))

func caveBackdrop(body):
	get_node("Sky/Sprite").set_self_modulate(Color(0, 0, 0))
	get_node("Far/Sprite").set_self_modulate(Color(0, 0.227451, 1))
	get_node("Middle/Sprite").set_self_modulate(Color(1, 0.384314, 0.847059))
	get_node("Near/Sprite").set_self_modulate(Color(1, 1, 1))


