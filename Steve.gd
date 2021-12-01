extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 250
const GRAVITY = 35
const WALLSPEED = -15
const WALLJUMP = 5000
const JUMPFORCE = -1100
var cas = Vector2(0, 60)
var coins = 0
var isHit = false
var walljumped = false

func _ready():
	Global.playerObject = self

func _physics_process(delta):
	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or ($wall_check.is_colliding())):
		if ($wall_check.is_colliding()):
			$Sprite.flip_h = not $Sprite.flip_h
			$wall_check.set_cast_to(-($wall_check.get_cast_to()))
			walljumped = true
		velocity.y = JUMPFORCE
		$SoundJump.play()
	if (walljumped):
		if ($wall_check.get_cast_to() == -cas):
			velocity.x = lerp(velocity.x, -1000, .2)
		else:
			velocity.x = lerp(velocity.x, 1000, .2)
		if velocity.x <= -875:
			walljumped = false
		elif velocity.x >= 875:
			walljumped = false
	if Input.is_action_pressed("right") and not walljumped:
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
		$wall_check.set_cast_to(cas)
		if is_on_floor() and not $SoundWalk.playing:
			$SoundWalk.play()
	if Input.is_action_pressed("left") and not walljumped:
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
		$wall_check.set_cast_to(-cas)
		if is_on_floor() and not $SoundWalk.playing:
			$SoundWalk.play()
	
	if (not (Input.is_action_pressed("left") || Input.is_action_pressed("right"))):
		$Sprite.play("idle")
	if not is_on_floor():
		$Sprite.play("air")
	
	if not velocity.y > 2000:
		velocity.y = velocity.y + GRAVITY
	
	if $wall_check.is_colliding():
		velocity.y = velocity.y + WALLSPEED
		$Sprite.play("wall")
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if not walljumped:
		velocity.x = lerp(velocity.x, 0, .3)

func bounce():
	velocity.y = JUMPFORCE * .8

func ouch(var enemyPosX):
	set_modulate(Color(1, .3, .3, .3))
	if position.x < enemyPosX:
		velocity.x = -900
	elif position.x > enemyPosX:
		velocity.x = 900
	velocity.y = JUMPFORCE * .5
	Input.action_release("left")
	Input.action_release("right")
	if isHit == false:
		Global.hearts = Global.hearts - 1
		$Timer.start()
		isHit = true

func _on_Fallzone_body_entered(body):
	Global.hearts = Global.hearts - 1
	if Global.hearts == 0:
		get_tree().change_scene("res://GameOver.tscn")
	else:
		get_tree().change_scene("res://Level" + str(Global.nextScene)+ ".tscn")

func _on_Timer_timeout():
	if Global.hearts == 0:
		get_tree().change_scene("res://GameOver.tscn")
	else:
		get_tree().change_scene("res://Level" + str(Global.nextScene)+ ".tscn")

func _on_MainZone_body_entered(body):
	$MainCamera.current = true
	if Global.nextScene == 2:
		$Light2D.enabled = false

func _on_HiddenZone_body_entered(body):
	$HiddenCamera.current = true
	if Global.nextScene == 2:
		$Light2D.enabled = true

