extends CharacterBody2D

const SPEED = 600.0

@onready var anim = $AnimatedSprite2D
@onready var health: Health = $Health
@onready var xp = $Level_System 

func _ready():
	add_to_group("player")
	
	health.damaged.connect(_on_damaged)
	health.died.connect(_on_died)
	health.healed.connect(_on_healed)
	
	xp.xp_gained.connect(_on_xp_gained)
	xp.level_up.connect(_on_level_up)

func _on_damaged(amount: int, from: Node):
	print("Tomou dano:", amount)
	anim.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	anim.modulate = Color.WHITE

func _on_died(from: Node):
	print("Player morreu")

	queue_free()
	get_tree().reload_current_scene()

func _on_healed(amount: int):
	print("Curou:", amount)

func _on_xp_gained(amount: int):
	print("Ganhou XP: ", amount)
	
func _on_level_up(level:int):
	print("Subiu de Nível!!! \nNivel atual: ", level) 

func _process(delta):

	# Funções de debug
	if Input.is_action_just_pressed("debug_damage"):
		health.apply_damage(1)

	if Input.is_action_just_pressed("debug_heal"):
		health.heal(1)
		
	if Input.is_action_just_pressed("debug_xp"):
		xp.add_xp(5)

func _physics_process(_delta):
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	# normaliza diagonal
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	velocity = direction * SPEED
	move_and_slide()

	# ANIMAÇÃO
	if direction == Vector2.ZERO:
		anim.play("stop")
	else:
		anim.play("moving")

	# VIRAR SPRITE
	if direction.x != 0:
		anim.flip_h = direction.x < 0
