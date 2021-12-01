extends TileMap

func _on_HiddenEntrance_body_entered(body):
	visible = false

func _on_HiddenExit_body_entered(body):
	visible = true


func _on_HiddenExit_body_exited(body):
	visible = true
