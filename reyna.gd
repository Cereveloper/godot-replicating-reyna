extends "res://entities/player/player_controller.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var backpoints: Array
var backpoints_rotation: Array
export var numpoints: int = 20
export var delay: float = 0.5
var internal_delay = 0
var tween_tp: Tween
var tween_tp_rot: Tween
var is_tweening = false
var next_point
var current_point = 0
export var reyna_eye : NodePath
export var shader_mesh : NodePath
var rey_eye: MeshInstance
signal use_e_ability
signal see_eye
var seeing_orb : bool = false
var stencil: ShaderMaterial
var dot_p: float
var isFront: bool
func store_transform():
	backpoints.push_front(self.global_transform)
	if backpoints.size() > numpoints :
		backpoints.pop_back()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	tween_tp = get_node("Tween") as Tween
	connect("use_e_ability", self, "_on_use_e_ability_use")
	connect("see_eye", self, "_on_seeing_reyna_orb")
#	tween_tp.connect("tween_completed", self, "_on_Tween_completed")
	rey_eye = get_node(reyna_eye) as MeshInstance
	stencil = get_node(shader_mesh).mesh.surface_get_material(0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	if rey_eye != null:
		dot_p = rotation.direction_to(rey_eye.global_transform.origin).dot(rotation)
		isFront = dot_p > 0.5
	internal_delay += delta
	if internal_delay > delay and is_tweening == false:
		store_transform()
		internal_delay = 0

	if Input.is_action_just_pressed("Ability1"):
		is_tweening = true
		emit_signal("use_e_ability")
#
	var dot_p: float = rotation.direction_to(rey_eye.global_transform.origin).dot(rotation)
	var isFront = dot_p > 0.5
	var current_value = stencil.get_shader_param("beer_factor")
	if isFront != seeing_orb:
		seeing_orb = isFront
		if isFront:
			emit_signal("see_eye");
		else:
			tween_tp.interpolate_method(self,"_on_Reyna_orb", current_value, 0.0, 0.5,Tween.TRANS_LINEAR)
			tween_tp.start()
			seeing_orb = false
			print("orb is in front:" + str(seeing_orb))


func _on_use_e_ability_use():
	pass
#	if current_point == 0:
#		tween_tp.interpolate_property(self, "global_transform", global_transform, backpoints[current_point], 0.5, Tween.TRANS_EXPO, Tween.EASE_IN,0.2)
#	elif current_point == backpoints.size()-1:
#		tween_tp.interpolate_property(self, "global_transform", global_transform, backpoints[current_point], 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT,0.2)
#	else:
#		tween_tp.interpolate_property(self, "global_transform", global_transform, backpoints[current_point], 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0 )
#	var rey_eye_direction = rotation.direction_to(rey_eye.transform.origin)
#	if rey_eye_direction.dot(rotation):
#		tween_tp.interpolate_method(self,"_on_Reyna_orb", 0.0, 1.5, 0.5,Tween.TRANS_LINEAR)
#		tween_tp.start()
#		yield(tween_tp, "tween_all_completed")
#	else:
#		tween_tp.interpolate_method(self,"_on_Reyna_orb", 0.0, 1.5, 0.5,Tween.TRANS_LINEAR)
#		tween_tp.start()
#		yield(tween_tp, "tween_all_completed")

#func _on_Tween_completed(object, key):
#	print("completed")
#	if current_point == backpoints.size()-1:
#		backpoints.clear()
#		current_point = 0
#		is_tweening = false
#		return
#	current_point += 1
##	emit_signal("use_e_ability")
func _on_seeing_reyna_orb():
	seeing_orb = true
	var current_value = stencil.get_shader_param("beer_factor")
#	if isFront:
	tween_tp.interpolate_method(self,"_on_Reyna_orb", current_value, 1.5, 0.5,Tween.TRANS_LINEAR)
	tween_tp.start()
	yield(tween_tp,"tween_all_completed")
#	else:
#		_on_finish_seeing_reyna_orb()

func _on_finish_seeing_reyna_orb():
	seeing_orb = true
	if not isFront:
		var current_value = stencil.get_shader_param("beer_factor")
		tween_tp.interpolate_method(self,"_on_Reyna_orb", current_value, 0.0, 0.5,Tween.TRANS_LINEAR)
		tween_tp.start()
		yield(tween_tp,"tween_all_completed")
	
func _on_Reyna_orb(value):
	stencil.set_shader_param("beer_factor", value)

func _on_eye_launched():
	print("launched")


