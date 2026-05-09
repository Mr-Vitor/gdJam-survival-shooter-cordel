class_name EnemyBase
extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var exp_scene:= preload("res://scenes/exp_point.tscn")

var health : int: set = _set_health
var max_health : int: set = _set_max_health
var speed : int
var dmg : int
var direction : Vector2
var knockback: Vector2
var player_inside:= false

func _set_max_health(value: int):
	max_health = value
	$HP.max_value = value

func _set_health(value: int):
	health = value
	$HP.value = value

func _ready():
	add_to_group("enemies")
	health.damaged.connect(_on_damaged)
	health.died.connect(_on_died)

func enemy_movement(delta):
	
	if health.hp > 0:
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

func take_damage(amount: int, from = null):
	health.apply_damage(amount, from)

func _on_damaged(amount, from):
	sprite_2d.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite_2d.modulate = Color.WHITE

func _on_died(from):
	die()

func die():
	var exp_point = exp_scene.instantiate()
	exp_point.position = position
	get_parent().add_child(exp_point)
	queue_free()

	
