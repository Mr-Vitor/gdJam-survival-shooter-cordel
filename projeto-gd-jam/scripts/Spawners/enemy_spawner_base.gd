class_name EnemySpawner
extends Area2D

signal hit_p(damage: int)

@export var node_ref : Node2D # Scene reference to spawn enemies
@onready var route = node_ref

var enemy_scene := preload("res://scenes/melee_enemy.tscn") # Assigned enemy to spawn
var enable_spawn := false
var spawn_points := []

var max_enemies_on_screen := 20
var enemy_counter := 0

var intervals := 39 # quantity of 30s intervals in gameplay
# -1 interval per 30s

# Code to spawn enemies from random spawn area
func enemy_manager():
	if self.enable_spawn:
		# Verifies spawn area presence
		if spawn_points.is_empty():
			return
		# Verifies enemy cap
		if enemy_counter >= max_enemies_on_screen:
			return
		
		# Selects random spawn area and calculates enemy spawn-point
		var spawn_area = spawn_points[randi() % spawn_points.size()]
		var rect_area = spawn_area.shape as RectangleShape2D
		var extention = rect_area.size 
		var local_pos = Vector2(
				randi_range(-extention.x, extention.x), 
				randi_range(-extention.y, extention.y)
			)
		var enemy_spawn_point = spawn_area.global_position + local_pos
		
		# Adds enemy to current scene and increases enemy counter
		var enemy = enemy_scene.instantiate()
		enemy.position = enemy_spawn_point
		enemy.damage_to_player.connect(_on_enemy_damage_to_player)
		route.add_child(enemy)
		enemy_counter += 1
		enemy.add_to_group("Enemies")

func enemy_spawn_scale(time_left: int, tick: bool):
	if time_left == self.intervals * 30 and tick:
		self.max_enemies_on_screen += 3
		self.intervals -= 1

# Enemy signaling damage to the player
func _on_enemy_damage_to_player(damage: int):
	hit_p.emit(damage)
