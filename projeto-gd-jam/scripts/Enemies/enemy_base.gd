class_name EnemyBase
extends CharacterBody2D

@onready var player:= get_node("/root/Testing Grounds/Player")
@onready var exp_scene:= preload("res://scenes/exp_point.tscn")

var health : float
var speed : int
var dmg : int
var direction : Vector2
var p_detected := false

<<<<<<< Updated upstream
func enemy_movement():
	if self.health > 0:
		direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * self.speed
		move_and_slide()
		
		#if velocity.x != 0:
			#$AnimatedSprite2D.flip_h = velocity.x < 0
=======
func _ready():
	add_to_group("enemies")
	health.damaged.connect(_on_damaged)
	health.died.connect(_on_died)

func enemy_movement(delta):
	
	if player == null:
		return
	
	if health.hp > 0:
		direction = (player.position - position).normalized()
		velocity = direction * speed
		knockback = knockback.move_toward(Vector2.ZERO, 1)
		velocity += knockback

		var collider = move_and_collide(velocity * delta)
		if collider:
			collider.get_collider().knockback = (
				collider.get_collider().global_position - global_position
			).normalized() * 30

		if velocity.x != 0:
			sprite_2d.flip_h = velocity.x < 0
>>>>>>> Stashed changes
	
	else:
		die()

func die():
	var exp_point = exp_scene.instantiate()
	exp_point.position = position
	get_parent().add_child(exp_point)
	queue_free()

	
