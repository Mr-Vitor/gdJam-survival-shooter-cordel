extends Node2D


#func _ready() -> void:
	#$Timer.timestamp.connect($Player/) # Add EnemySpawner function for signal


func _on_melee_spawner_hit_p() -> void:
	print("Hit by melee")


func _on_shooter_spawner_hit_p() -> void:
	print("Hit by shooter")
