extends EnemySpawner


func _ready() -> void:
	enemy_scene = preload("res://scenes/speedster_enemy.tscn")
	
	for i in get_children():
		if i is CollisionShape2D:
			spawn_points.append(i)
			
	max_enemies_on_screen = 10
	intervals = 4


func _on_timer_timeout() -> void:
	enemy_manager()
