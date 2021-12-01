extends Node2D


func _ready():
	$AnimationPlayer2.play("backgroundAnimation")
	$AnimationPlayer1.play("flyin")
	$MusicTimer.start()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "flyin":
		$Timer.start()
		$AnimationPlayer1.play("playerjumping")
		$playersprite/SoundJump.play()
		$AnimationPlayer2.play("groundDrop")


func _on_Timer_timeout():
	get_tree().change_scene("res://TitleMenu.tscn")


func _on_MusicTimer_timeout():
	$MusicSplashScreen.play()
