extends EnemySpawner

func _ready():
	enemy_scene = preload("res://scenes/melee_enemy.tscn")
	for i in get_children():
		if i is CollisionShape2D:
			spawn_points.append(i)
			
	enable_spawn = true
	
# Spawns enemy upon timer reaching 0
func _on_timer_timeout():
	enemy_spawn()
