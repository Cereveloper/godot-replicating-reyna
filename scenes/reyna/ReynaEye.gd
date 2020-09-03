extends MeshInstance


var possible_affected_players: Array
var is_launched = false
signal seeing_eye
signal finish_seeing_eye

func _ready():
	for member in get_tree().get_nodes_in_group("Player"):
		print(member)
		connect("seeing_eye", member, "_on_seeing_reyna_orb")
		connect("finish_seeing_eye", member, "_on_finish_seeing_reyna_orb")
	

func _on_Area_body_entered(body: Node):
	if body.is_in_group("Player") and not (body in possible_affected_players):
		possible_affected_players.append(body)
	print(possible_affected_players)
	

func _on_Area_body_exited(body):
	pass


func _on_Timer_timeout():
	queue_free()


func _on_eye_visible_camera_entered(camera: Camera):
	emit_signal("finish_seeing_eye")

func _on_eye_visible_camera_exited(camera):
	emit_signal("finish_seeing_eye")

