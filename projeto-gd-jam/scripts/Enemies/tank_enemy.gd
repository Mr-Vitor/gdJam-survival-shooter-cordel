extends EnemyBase

signal damage_to_player(damage: int)
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var damage_timer:= $DamageTimer

func _ready() -> void:
	super()
	max_health = 40
	health = 40
	dmg = 12
	speed = 10

func _physics_process(_delta):
	enemy_movement(_delta)
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 10

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = true
		damage_timer.start()

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		damage_timer.stop()

func _on_damage_timer_timeout() -> void:
	damage_to_player.emit(dmg) 
