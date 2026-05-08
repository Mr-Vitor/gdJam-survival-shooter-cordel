extends CharacterBody2D

var health := 100
var SPEED = 100.0
var direction : Vector2
var knockback: Vector2

func _physics_process(_delta):
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	direction = Vector2(direction_x, direction_y)
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_collide(velocity * _delta)
