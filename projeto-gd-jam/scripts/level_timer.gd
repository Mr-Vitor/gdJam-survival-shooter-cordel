extends Timer

var timestamp : Signal

# Monitor game timer and send signal each 5 min to spawn boss
func _process(_delta):
	if wait_time == 900:
		timestamp.emit(wait_time)
	else: pass
	
# Monitor game timer to scale enemy spawn-rate
#func time_scale():
