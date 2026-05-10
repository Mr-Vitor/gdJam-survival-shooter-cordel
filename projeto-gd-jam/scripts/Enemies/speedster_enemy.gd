extends EnemyBase

signal damage_to_player(damage: int)
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_timer:= $DamageTimer

func _ready() -> void:
	super()
	max_health = 8
	health = 8
	dmg = 5
	speed = 35 
	anim.play("Chase")

func _physics_process(_delta):
	enemy_movement(_delta)
	if velocity.x != 0:
		anim.flip_h = velocity.x < 10

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
