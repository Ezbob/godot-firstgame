extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

var mob_types = ["walk", "swim", "fly"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	$AnimatedSprite.play()

func _on_Visibility_screen_exited() -> void:
	free_mob()
	
func _on_start_game() -> void:
	free_mob()
	
func free_mob() -> void:
	$AnimatedSprite.stop()
	queue_free()
