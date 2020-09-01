extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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
		print("wehe")
