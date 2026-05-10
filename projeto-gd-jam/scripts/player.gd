extends CharacterBody2D

const SPEED = 110.0

@onready var anim = $AnimatedSprite2D
@onready var health: Health = $Health
@onready var xp = $Level_System 
@onready var attack_area = $MeleeAttackArea
@onready var attack_sprite: Sprite2D = $MeleeAttackArea/CollisionShape2D/Sprite2D

var isAttacking = false
var facing_direction = Vector2.DOWN
var knockback : Vector2

func _ready():
	add_to_group("player")
	
	health.damaged.connect(_on_damaged)
	health.died.connect(_on_died)
	health.healed.connect(_on_healed)
	
	xp.level_up.connect(_on_level_up)

	attack_area.monitoring = true
	attack_area.monitorable = true

func _on_damaged(amount: int):
	print("Tomou dano:", amount)
	anim.modulate = Color.RED
	await get_tree().create_timer(0.5).timeout
	anim.modulate = Color.WHITE

func _on_died():
	print("Player morreu")

	queue_free()
	get_tree().reload_current_scene()

func _on_healed(amount: int):
	print("Curou:", amount)
	
func _on_level_up(_level):
	pass

func _process(_delta):
	if Input.is_action_just_pressed("debug_heal"):
		health.heal(1)

func _physics_process(_delta):
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	# normaliza diagonal
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		facing_direction = direction

	velocity = direction * SPEED
	knockback = knockback.move_toward(Vector2.ZERO, 20)
	velocity += knockback
	move_and_slide()

	# ANIMAÇÃO
	if direction == Vector2.ZERO:
		anim.play("stop")
	else:
		anim.play("moving")

	# VIRAR SPRITE
	if direction.x > 0:
		anim.flip_h = direction.x < 0
		if !isAttacking:
			update_attack_position(Vector2.RIGHT)
			attack_sprite.flip_h = false
	elif direction.x < 0:
		anim.flip_h = direction.x < 0
		if !isAttacking:
			update_attack_position(Vector2.LEFT)
			attack_sprite.flip_h = true
		
func attack():
	if isAttacking:
		attack_sprite.visible = true
		var bodies = attack_area.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("enemies"):
				body.take_damage(15)
		await get_tree().create_timer(0.25).timeout
		isAttacking = false
		attack_sprite.visible = false

func update_attack_position(direction):
	var distance = 1
	if direction == Vector2.LEFT:
		distance = 190
	attack_area.position = direction * distance

func _on_attack_cooldown_timeout() -> void:
	isAttacking = true
	attack()
