extends Area2D

var detect = false
func _ready():
	$Sprite.play("sleep")
	#$AnimationPlayer.play("sleeping")

func _physics_process(delta):
	if detect:
		$Sprite.play("awake")
		$AnimationPlayer.play("moving")
	if (not detect):
		$Sprite.play("sleep")
		$AnimationPlayer.play("sleeping")

func _on_detection_body_entered(body):
	detect = true


func _on_detection_body_exited(body):
	detect = false


func _on_SandSentry_body_entered(body):
	body.ouch(position.x)
