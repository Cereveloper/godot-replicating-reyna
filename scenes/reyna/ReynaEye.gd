extends MeshInstance


var affected_players: Array
var is_launched = false
signal seeing_eye
signal finish_seeing_eye
signal in_range
signal not_in_range

func connect_signals(body):
	connect("seeing_eye", body, "_on_seeing_reyna_orb")
	connect("finish_seeing_eye", body, "_on_finish_seeing_reyna_orb")
	connect("in_range", body, "_on_reyna_orb_range")
	connect("not_in_range", body, "_on_reyna_orb_exit_range")

func disconnect_signals(body):
	disconnect("seeing_eye", body, "_on_seeing_reyna_orb")
	disconnect("finish_seeing_eye", body, "_on_finish_seeing_reyna_orb")
	disconnect("in_range", body, "_on_reyna_orb_range")
	disconnect("not_in_range", body, "_on_reyna_orb_exit_range")
	

func _on_Area_body_entered(body: Node):
#	if body.is_in_group("Player") and not body in affected_players:
	connect_signals(body)
	emit_signal("in_range")
	affected_players.append(body)

func _on_Area_body_exited(body):
	emit_signal("not_in_range")
	disconnect_signals(body)
	affected_players.remove(affected_players.find(body))
	

func _on_Timer_timeout():
	for body in affected_players:
		disconnect_signals(body)
	queue_free()


func _on_eye_visible_camera_entered(camera: Camera):
	emit_signal("seeing_eye")

func _on_eye_visible_camera_exited(camera):
	emit_signal("finish_seeing_eye")

