extends CharacterBody2D


var speed := 300.0
var direction: Vector2

func _physics_process(_delta):
	move_and_slide()

func _on_attract_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		direction = (body.position - position)
		direction = direction.normalized()
		velocity = direction * speed


func _on_pickup_range_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			print("Pegou XP!")
			queue_free()
