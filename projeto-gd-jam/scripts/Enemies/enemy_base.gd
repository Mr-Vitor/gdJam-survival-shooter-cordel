class_name EnemyBase
extends CharacterBody2D

@onready var player:= get_node("/root/Testing Grounds/Player")
@onready var exp_scene:= preload("res://scenes/exp_point.tscn")

var health : float
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
	
	else:
		die()

func die():
	var exp_point = exp_scene.instantiate()
	exp_point.position = position
	get_parent().add_child(exp_point)
	queue_free()

	
