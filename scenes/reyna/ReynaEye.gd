extends MeshInstance


var affected_players: Array
var is_launched = false
var blind_type: String = "eye"

signal eye_thrown(eye)

func _ready():
	var player = get_tree().get_nodes_in_group("Player")[0]
	connect("eye_thrown", player, "_on_eye_thrown")
	emit_signal("eye_thrown", self)
	
func _on_Timer_timeout():
	queue_free()

