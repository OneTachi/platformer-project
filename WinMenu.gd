extends Control


func _ready():
	if Global.nextScene > 2:
		$Label.text = "Game Complete!"
		$Label.get("custom_fonts/font").set_size(50)
		
		$Next.queue_free()
