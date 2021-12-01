extends KinematicBody2D

var velocity = Vector2()
var speed = 50
var ramSpeed = 200
var isHit = false
var color = Color(1,1,1,.1)
var transparent = Color(0, 0, 0, .3)
export var direction = -1
export var detects_cliffs = true
export var aggressive = false
var ramDone = true
const GRAVITY = 30

func _ready():
	if direction == 1:
		$Sprite.flip_h = true
	$floor_check.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_check.enabled = detects_cliffs
	if detects_cliffs == false:
		set_modulate(Color(.4, 1, .4, 1))
		color = Color(.4, 1, .4, .1)
	if aggressive:
		set_modulate(Color(1.2, .1, .1, 1))
		color = Color(1.2, .1, .1, .1)
	$ram_check.enabled = aggressive
	$ram_check.set_cast_to($ram_check.get_cast_to() * direction)

func _physics_process(delta):
	if is_on_wall() or not $floor_check.is_colliding() and detects_cliffs and is_on_floor() and ramDone:
		direction = -direction
		$Sprite.flip_h = not $Sprite.flip_h
		$floor_check.position.x = $CollisionShape2D.shape.get_extents().x * direction
		$ram_check.set_cast_to(-($ram_check.get_cast_to()))
	
	$Sprite.speed_scale = 1
	velocity.y = velocity.y + GRAVITY
	velocity.x = speed * direction
	if $ram_check.is_colliding() and $ram_check.get_collider() == Global.playerObject:
		$TimerRam.start()
		ramDone = false
	
	if ramDone == false:
		$Sprite.speed_scale = 3
		velocity.x = ramSpeed * direction
		$floor_check.enabled = false
	
	
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_top_check_body_entered(body):
	$Sprite.play("squash")
	direction = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	set_collision_mask_bit(4, false)
	set_collision_mask_bit(5, false)
	$top_check.set_collision_mask_bit(0, false)
	$top_check.set_collision_mask_bit(5, false)
	$side_check.set_collision_mask_bit(0, false)
	$Timer.start()
	body.bounce()
	$SoundSquash.play()


func _on_side_check_body_entered(body):
	body.ouch(position.x)

func _on_Timer_timeout():
	queue_free()

func _on_TimerRam_timeout():
	ramDone = true
	$floor_check.enabled = detects_cliffs

func ouch(var enemyPosX):
	if position.x < enemyPosX:
		speed = -100
	elif position.x > enemyPosX:
		speed = 100
	direction = 1
	velocity.y = -600
	ramDone = true
	if isHit == false:
		$TimerDeath.start()
		isHit = true
	#color = color.blend(transparent)
	set_modulate(color)
	$SoundSquash.play()


func _on_TimerDeath_timeout():
	queue_free()
