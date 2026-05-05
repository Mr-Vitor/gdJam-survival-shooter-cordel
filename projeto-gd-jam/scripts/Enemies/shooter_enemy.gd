extends EnemyBase

signal damage_to_player

@export var shooting_cooldown : Timer

var bullet_scene := preload("res://scenes/bullet.tscn")
var is_ready := false
var last_shot := false

func _ready() -> void:
	self.health = 18
	self.dmg = 7
	self.speed = 50

func _physics_process(_delta):
	self.enemy_movement()

func bullet_shooting(s_ready: bool, last: bool):
	if s_ready or last:
		var bullet = bullet_scene.instantiate()
		bullet.direction = global_position.direction_to(player.position)
		
		get_tree().current_scene.add_child(bullet)
		bullet.position = position
		
		if last:
			self.last_shot = false
			self.speed = 60

func _on_area_2d_body_entered(_body):
	if !(_body.is_in_group("Enemies")):
		damage_to_player.emit()

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
