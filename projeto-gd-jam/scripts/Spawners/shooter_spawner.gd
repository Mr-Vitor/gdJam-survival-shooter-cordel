extends EnemySpawner

func _ready():
	enemy_scene = preload("res://scenes/shooter_enemy.tscn")
	for i in get_children():
		if i is CollisionShape2D:
			spawn_points.append(i)
	
	max_enemies_on_screen = 10
	intervals = 38

# Spawns enemy upon timer reaching 0
func _on_timer_timeout():
	enemy_manager() 
