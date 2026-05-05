extends Node2D

@onready var melee_spawner: = $Player/MeleeSpawner
@onready var shooter_spawner: = $Player/ShooterSpawner

func _on_melee_spawner_hit_p() -> void:
	print("Hit by melee")

func _on_shooter_spawner_hit_p() -> void:
	print("Hit by shooter")

func _on_timer_shooter_start_spawn() -> void:
	shooter_spawner.enable_spawn = true

func _on_timer_spawn_rate_increase(time_left: int, spawn_rate_tick: bool) -> void:
	print(time_left, " | ", spawn_rate_tick)
	melee_spawner.enemy_spawn_scale(time_left, spawn_rate_tick)
	shooter_spawner.enemy_spawn_scale(time_left, spawn_rate_tick)
	print("Controll down")
