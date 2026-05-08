extends Node2D

@onready var melee_spawner: = $Player/Camera2D/MeleeSpawner
@onready var shooter_spawner: = $Player/Camera2D/ShooterSpawner
@onready var tank_spawner: = $Player/Camera2D/TankSpawner
@onready var speedster_spawner: = $Player/Camera2D/SpeedsterSpawner
@onready var player := $Player

# Damage signals
# --- Melee ---
func _on_melee_spawner_hit_p(damage: int):
	if player.health.hp > 0:
		player.health.apply_damage(damage)
	else:
		print("You Died!")

# --- Shooter ---
func _on_shooter_spawner_hit_p(damage: int):
	if player.health.hp > 0:
		player.health.apply_damage(damage)
	else:
		print("You Died!")

# --- Tank ---
func _on_tank_spawner_hit_p(damage: int) -> void:
	if player.health.hp > 0:
		player.health.apply_damage(damage)
	else:
		print("You Died!")

# --- Speedster ---
func _on_speedster_spawner_hit_p(damage: int) -> void:
	if player.health.hp > 0:
		player.health.apply_damage(damage)
	else:
		print("You Died!")

# Spawn time signals
# --- Shooter ---
func _on_timer_shooter_start_spawn() -> void:
	shooter_spawner.enable_spawn = true

# --- Tank ---
func _on_timer_tank_start_spawn() -> void:
	tank_spawner.enable_spawn = true

# --- Speedster ---
func _on_timer_speedster_start_spawn() -> void:
	speedster_spawner.enable_spawn = true

# Spawn-rate increase signal
func _on_timer_spawn_rate_increase(time_left: int, spawn_rate_tick: bool) -> void:
	melee_spawner.enemy_spawn_scale(time_left, spawn_rate_tick)
	shooter_spawner.enemy_spawn_scale(time_left, spawn_rate_tick)
