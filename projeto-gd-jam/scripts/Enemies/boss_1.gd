extends EnemyBase


func _ready() -> void:
	health = 200
	speed = 60
	dmg = 25
	



func _process(delta: float) -> void:
	enemy_movement(delta)
