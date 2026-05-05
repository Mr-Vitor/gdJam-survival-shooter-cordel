extends EnemySpawner

func _ready():
	for i in get_children():
		if i is CollisionShape2D:
			spawn_points.append(i)
			
	self.enable_spawn = true
	
# Spawns enemy upon timer reaching 0
func _on_timer_timeout():
	enemy_spawn()
