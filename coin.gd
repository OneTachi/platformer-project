extends Area2D


signal coin_collected
signal coin_exists
signal bonus_exists

func _ready():
	emit_signal("coin_exists")
	emit_signal("bonus_exists")

func _on_coin_body_entered(body):
	$AnimationPlayer.play("bounce")
	emit_signal("coin_collected")
	set_collision_mask_bit(0, false)
	$SoundCollect.play()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()


