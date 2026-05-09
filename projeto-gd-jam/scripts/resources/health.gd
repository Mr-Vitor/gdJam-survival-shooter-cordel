extends Node
class_name Health

signal damaged(amount: int, from: Node)
signal died(from: Node)
signal healed(amount: int)

@export var max_hp: int = 150
@export var invincibility_time: float = 0.75

var hp: int 
var invincible: bool = false

# Evita danos no mesmo frame/tick
var _last_damage_frame: int = -1

func _ready() -> void:
	hp = max_hp
	
func reset() -> void:
	hp = max_hp
	invincible = false
	_last_damage_frame = -1
	
func apply_damage(amount: int) -> bool:
	if hp - amount <= 0:
		emit_signal("died")
		return true
		
	if invincible:
		return false
		
	var current_frame := Engine.get_physics_frames()
	if _last_damage_frame == current_frame:
		return false
	_last_damage_frame = current_frame
	
	hp = max(hp - amount, 0)
	emit_signal("damaged", amount)

		
	_start_invincibility()
	return true
	
func heal(amount: int) -> void:
	if amount <= 0:
		return
	if hp <= 0:
		return
		
	var old := hp
	hp = min(hp + amount, max_hp)
	var delta := hp - old
	if delta > 0:
		emit_signal("healed", delta)
		
func _start_invincibility() -> void:
	invincible = true
	
	# timer simples
	await get_tree().create_timer(invincibility_time).timeout
	invincible = false
