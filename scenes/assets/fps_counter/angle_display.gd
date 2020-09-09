extends Label

##################################################

export var enabled := true
onready var player: Node = get_node("../Player")
##################################################

func _process(_delta: float) -> void:
	if enabled:
		text = "Angle: "
		text += str(player.angle)
