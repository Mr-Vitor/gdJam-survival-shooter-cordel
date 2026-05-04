class_name EnemySpawner
extends Area2D

signal hit_p

@export var node_ref : Node2D # Scene reference to spawn enemies
@onready var route = node_ref
var enemy_scene := preload("res://scenes/melee_enemy.tscn") # Assigned enemy to spawn
var spawn_points := []
var start_spawn_at := 0.0


# Code to spawn enemies from random spawn area
func enemy_spawn():
	if start_spawning():
		if spawn_points.is_empty():
			print("Falhou")
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
		enemy.damage_to_player.connect(hit)
		route.add_child(enemy)
		enemy.add_to_group("Enemies")

func start_spawning() -> bool: 
	 # Receives current timer value and checks if equals to 
	 # designated spawn time
	#if variavel_do_timer <= self.start_spawn_at:
		#return true
	return true
	

# Enemy spawn-rate

# Enemy signaling damage to the player
func hit():
	hit_p.emit()
