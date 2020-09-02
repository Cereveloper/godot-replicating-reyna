extends MeshInstance


var possible_affected_players: Array
var is_launched = false
signal eye_launched

func _ready():
	for member in get_tree().get_nodes_in_group("Enemy"):
		connect("eye_launched", member, "_on_Area_body_entered", [member])
	

func _process(delta):
	if is_launched:
		for enemy in possible_affected_players:
			pass

func _on_Area_body_entered(body: Node):
	if body.is_in_group("Enemy"):
		body._on_seeing_reyna_orb()


func _on_Area_body_exited(body):
	if body.is_in_group("Enemy"):
		body._on_finish_seeing_reyna_orb()


func _on_Timer_timeout():
	queue_free()
