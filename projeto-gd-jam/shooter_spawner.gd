extends EnemySpawner


func _ready():
	enemy_scene = preload("res://scenes/shooter_enemy.tscn")
	start_spawn_at = 0.0
	for i in get_children():
		if i is CollisionShape2D:
			spawn_points.append(i)

func _on_timer_timeout() -> void:
	enemy_spawn() # Replace with function body.
