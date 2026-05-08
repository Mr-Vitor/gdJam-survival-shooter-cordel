class_name EnemyBase
extends CharacterBody2D

@onready var player:= get_node("/root/Testing Grounds/Player")
@onready var exp_scene:= preload("res://scenes/exp_point.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D

var health : float
var speed : int
var dmg : int
var direction : Vector2
var knockback: Vector2

func enemy_movement(delta):
	if self.health > 0:
		direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * self.speed
		knockback = knockback.move_toward(Vector2.ZERO, 1)
		velocity += knockback
		var collider = move_and_collide(velocity * delta)
		if collider:
			collider.get_collider().knockback = (collider.get_collider().global_position - 
			global_position).normalized() * 30
		
		if velocity.x != 0:
			sprite_2d.flip_h = velocity.x < 10
	
	else:
		die()

func die():
	var exp_point = exp_scene.instantiate()
	exp_point.position = position
	get_parent().add_child(exp_point)
	queue_free()

	
