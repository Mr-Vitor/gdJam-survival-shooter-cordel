extends CharacterBody2D

const SPEED = 600.0

@onready var anim = $AnimatedSprite2D

func _physics_process(_delta):
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	# normaliza diagonal
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	velocity = direction * SPEED
	move_and_slide()

	# ANIMAÇÃO
	if direction == Vector2.ZERO:
		anim.play("stop")
	else:
		anim.play("moving")

	# VIRAR SPRITE
	if direction.x != 0:
		anim.flip_h = direction.x < 0
