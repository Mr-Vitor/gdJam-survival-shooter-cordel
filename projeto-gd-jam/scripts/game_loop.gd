extends Node2D

@onready var melee_spawner: = $Player/MeleeSpawner
@onready var shooter_spawner: = $Player/ShooterSpawner
@onready var player := $Player


func _on_melee_spawner_hit_p(damage: int):
	if player.health > 0:
		player.health -= damage
	else:
		print("You Died!")
		
	print(player.health)

func _on_shooter_spawner_hit_p(damage: int):
	if player.health > 0:
		player.health -= damage
	else:
		print("You Died!")
		
	print(player.health)

func _on_timer_shooter_start_spawn() -> void:
	shooter_spawner.enable_spawn = true

func _on_timer_spawn_rate_increase(time_left: int, spawn_rate_tick: bool) -> void:
	melee_spawner.enemy_spawn_scale(time_left, spawn_rate_tick)
	shooter_spawner.enemy_spawn_scale(time_left, spawn_rate_tick)
