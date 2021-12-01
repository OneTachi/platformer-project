extends Area2D


func _on_Spike_body_entered(body):
	body.ouch(position.x)
