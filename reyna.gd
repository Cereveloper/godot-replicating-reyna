extends "res://entities/player/player_controller.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tween_tp: Tween

export var reyna_eye : NodePath
export var shader_mesh : NodePath
var rey_eye: MeshInstance

var seeing_orb : bool = false
var in_range_orb : bool = false
var stencil: ShaderMaterial
var dot_p: float
var isFront: bool
var camera


# Called when the node enters the scene tree for the first time.
func _ready():
	tween_tp = get_node("Tween") as Tween
	rey_eye = get_node(reyna_eye) as MeshInstance
	stencil = get_node(shader_mesh).mesh.surface_get_material(0)
	camera = get_viewport().get_camera()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
#	if rey_eye != null:
#		dot_p = rotation.direction_to(rey_eye.global_transform.origin).dot(rotation)
#		isFront = dot_p > 0.5

	if Input.is_action_just_pressed("Ability1"):
		emit_signal("use_e_ability")
	

#	var dot_p: float = rotation.direction_to(rey_eye.global_transform.origin).dot(rotation)
#	var isFront = dot_p > 0.5
#	current_shader_value = stencil.get_shader_param("beer_factor")
#	if isFront != seeing_orb:
#		seeing_orb = isFront
#	if  not result.empty():
#		emit_signal("see_eye");
#	else:
#		tween_tp.interpolate_method(self,"_on_Reyna_orb", current_value, 0.0, 0.5,Tween.TRANS_LINEAR)
#		tween_tp.start()
#		seeing_orb = false
#		print("orb is in front:" + str(seeing_orb))


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


func is_seeing_orb_and_in_range():
	var current_value = stencil.get_shader_param("beer_factor")
	if seeing_orb and in_range_orb:
		tween_tp.interpolate_method(self,"interpolate_reyna_orb_effect", current_value, 1.5, 0.5,Tween.TRANS_LINEAR)
	else:
		tween_tp.interpolate_method(self,"interpolate_reyna_orb_effect", current_value, 0.0, 0.5,Tween.TRANS_LINEAR)
	tween_tp.start()
	yield(tween_tp,"tween_all_completed")
	
func _on_seeing_reyna_orb():
	seeing_orb = true
#	var current_value = stencil.get_shader_param("beer_factor")
#	tween_tp.interpolate_method(self,"interpolate_reyna_orb_effect", current_value, 1.5, 0.5,Tween.TRANS_LINEAR)
#	tween_tp.start()
#	yield(tween_tp,"tween_all_completed")

func _on_finish_seeing_reyna_orb():
	seeing_orb = false
#	var current_value = stencil.get_shader_param("beer_factor")
#	tween_tp.interpolate_method(self,"interpolate_reyna_orb_effect", current_value, 0.0, 0.5,Tween.TRANS_LINEAR)
#	tween_tp.start()
#	yield(tween_tp,"tween_all_completed")

func _on_reyna_orb_range():
	in_range_orb = true
	
func _on_reyna_orb_exit_range():
	in_range_orb = false

func interpolate_reyna_orb_effect(value):
	stencil.set_shader_param("beer_factor", value)


