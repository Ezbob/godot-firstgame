extends Area2D

signal hit

# Speed in (pixels per second)
export var speed = 400 # export for inspector setting
var velocity = Vector2()
var screen_size

var target = Vector2()

func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()
	
func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		target = event.position

func _process(delta: float) -> void:

	if position.distance_to(target) > 10:
		velocity = (target - position).normalized() * speed
	else:
		velocity = Vector2()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.set_speed_scale(2)
	else:
		$AnimatedSprite.set_speed_scale(0.4)

	
	position += velocity * delta
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func _on_Player_body_entered(_body: RigidBody2D) -> void:
	emit_signal("hit")
	disable_me()

func start(pos: Vector2) -> void:
	position = pos
	target = pos
	enable_me()

func disable_me() -> void:
	hide()
	$AnimatedSprite.stop()
	$CollisionShape2D.set_deferred("disabled", true) # we need to wait for when it is safe to set disabled to true

func enable_me() -> void:
	show()
	$AnimatedSprite.play()
	$CollisionShape2D.disabled = false
