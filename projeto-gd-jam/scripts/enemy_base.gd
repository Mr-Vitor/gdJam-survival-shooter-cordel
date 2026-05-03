class_name EnemyBase
extends CharacterBody2D

@onready var player = get_node("/root/Testing Grounds/Player")

var health : float
var speed : int
var dmg : float
var direction : Vector2

func movement():
	direction = (player.position - position)
	direction = direction.normalized()
	velocity = direction * self.speed
	move_and_slide()
