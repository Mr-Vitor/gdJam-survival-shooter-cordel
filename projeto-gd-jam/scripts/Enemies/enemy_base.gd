class_name EnemyBase
extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var exp_scene:= preload("res://scenes/exp_point.tscn")

signal enemy_death

var health : int: set = _set_health
var max_health : int: set = _set_max_health
var speed : int
var dmg : int
var direction : Vector2
var p_detected := false

func enemy_movement():
	if self.health > 0:
		direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * self.speed
		move_and_slide()
		
		#if velocity.x != 0:
			#$AnimatedSprite2D.flip_h = velocity.x < 0
		direction = (player.position - position).normalized()
		velocity = direction * speed
		knockback = knockback.move_toward(Vector2.ZERO, 1)
		velocity += knockback

		var collider = move_and_collide(velocity * delta)
		if collider:
			collider.get_collider().knockback = (collider.get_collider().global_position - 
			global_position).normalized() * 30
      
	else:
		die()

func take_damage(damage: int):
	_set_health(health - damage)

func die():
	var exp_point = exp_scene.instantiate()
	exp_point.position = position
	get_parent().add_child(exp_point)
	enemy_death.emit()
	queue_free()
