class_name EnemyBase
extends CharacterBody2D

@onready var player = get_node("/root/Testing Grounds/Player")


var health : float
var speed : int
var dmg : float
var direction : Vector2

func enemy_movement():
	if self.health > 0:
		direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * self.speed
		move_and_slide()
		
		#if velocity.x != 0:
			#$AnimatedSprite2D.flip_h = velocity.x < 0
	
	else:
		queue_free()
