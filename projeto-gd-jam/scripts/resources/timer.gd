extends Label

var total_time_in_seconds: int = 0

func _on_s_timeout() -> void:
	total_time_in_seconds += 1
	var m = int(total_time_in_seconds/60.0)
	var s = total_time_in_seconds - m * 60
	text = '%02d:%02d' % [m, s]
