extends Area2D

@export var node_ref : Node2D
@onready var route = node_ref
var enemy_scene := preload("res://scenes/melee_enemy.tscn")
var spawn_points := []

func _ready():
	for i in get_children():
		if i is CollisionShape2D:
			spawn_points.append(i)


func _on_timer_timeout():
	if spawn_points.is_empty():
		return
	var spawn_area = spawn_points[randi() % spawn_points.size()]
	var rect_area = spawn_area.shape as RectangleShape2D
	var extention = rect_area.size 
	
	var local_pos = Vector2(
			randi_range(-extention.x, extention.x), 
			randi_range(-extention.y, extention.y)
		)
	
	var spawn_vector = spawn_area.global_position + local_pos
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_vector
	route.add_child(enemy)
