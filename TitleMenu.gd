extends Control


func _ready():
	$AnimationPlayer.play("zoom")


func _on_animation_finished(anim_name):
	$AnimationPlayer.play("buttons")
