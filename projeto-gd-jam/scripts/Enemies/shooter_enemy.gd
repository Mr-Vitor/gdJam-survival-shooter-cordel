extends EnemyBase

signal damage_to_player(damage: int)

@export var shooting_cooldown : Timer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var damage_timer:= $DamageTimer

var bullet_scene := preload("res://scenes/bullet.tscn")
var is_ready := false
var last_shot := false

func _ready():
	super()
	health.max_hp = 18
	health.hp = 18
	dmg = 7
	speed = 40

func _physics_process(_delta):
	enemy_movement(_delta)
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 10

# Create and shoot bullet
# On contact with player, emits signal to deal damage
func bullet_shooting(s_ready: bool, last: bool):
	if s_ready or last:
		var bullet = bullet_scene.instantiate()
		bullet.direction = global_position.direction_to(player.position)
		bullet.position = position
		bullet.deal_damage.connect(bullet_damage)
		get_parent().add_child(bullet)
		
		if last:
			last_shot = false
			speed = 60

func bullet_damage():
	damage_to_player.emit(dmg)

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = true
		damage_timer.start()

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		damage_timer.stop()

func _on_damage_timer_timeout() -> void: 
	bullet_damage()

func _on_shooting_area_body_entered(_body):
	if !(_body.is_in_group("Enemies")):
		speed = 0
		if is_ready == false:
			is_ready = true
			shooting_cooldown.start()

func _on_shooting_area_body_exited(_body):
	if !(_body.is_in_group("Enemies")):
		if is_ready:
			is_ready = false
			last_shot = true
			shooting_cooldown.one_shot = true


func _on_shooting_cooldown_timeout():
	shooting_cooldown.one_shot = false
	bullet_shooting(is_ready, last_shot)
