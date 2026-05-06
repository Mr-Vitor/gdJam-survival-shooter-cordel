extends Timer

signal shooter_start_spawn
signal spawn_rate_increase

var spawn_rate_tick : bool
var last_second := -1


# Monitor game timer and send signal each 5 min to spawn boss
func _process(_delta):
	var current_time = int(wait_time - time_left)
	
	if current_time != last_second:
		last_second = current_time
		
		# Start spawning enemies according to in-game time
		if current_time == 60: # Change to Match later
			shooter_start_spawn.emit()
		else: pass
	
		# Monitor game timer to scale enemy spawn-rate
		if current_time % 30 == 0 and current_time != 0:
			spawn_rate_tick = true
			spawn_rate_increase.emit(int(wait_time - current_time),spawn_rate_tick)
		else:
			spawn_rate_tick = false
	

#func time_scale():
