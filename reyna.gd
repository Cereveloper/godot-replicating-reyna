extends "res://entities/player/player_controller.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tween_tp: Tween

export var shader_mesh : NodePath

var seeing_orb : bool = false
var in_range_orb : bool = false
var stencil: ShaderMaterial
var dot_p: float
var isFront: bool
var camera
var reyna_eye: MeshInstance
var blinded: bool = false
var blind_type
var dir
var angle

signal see_eye
signal finish_see_eye

# Called when the node enters the scene tree for the first time.
func _ready():
	tween_tp = get_node("Tween") as Tween
	stencil = get_node(shader_mesh).mesh.surface_get_material(0)
	camera = get_viewport().get_camera()
	connect("see_eye", self, "_on_see_eye")
	connect("finish_see_eye", self, "_on_finish_see_eye")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
#	if rey_eye != null:
#		dot_p = rotation.direction_to(rey_eye.global_transform.origin).dot(rotation)
#		isFront = dot_p > 0.5

	if Input.is_action_just_pressed("Ability1"):
		emit_signal("use_e_ability")
	
	if reyna_eye:
		dir = self.global_transform.origin - reyna_eye.global_transform.origin
		var b = self.transform.basis.z
		angle = rad2deg(b.angle_to(dir))

		if abs(angle) < 60:
			seeing_orb = isFront
			emit_signal("see_eye")
		else:
			emit_signal("finish_see_eye")
			seeing_orb = false

#		yield(tween_tp, "tween_all_completed")

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

func _on_see_eye():
	var current_shader_value = stencil.get_shader_param("beer_factor")
	tween_tp.interpolate_method(self,"interpolate_reyna_orb_effect", current_shader_value, 0.7, 0.5,Tween.TRANS_LINEAR)
	tween_tp.start()
	yield(tween_tp, "tween_all_completed")

func _on_finish_see_eye():
	var current_shader_value = stencil.get_shader_param("beer_factor")
	tween_tp.interpolate_method(self,"interpolate_reyna_orb_effect", current_shader_value, 0.0, 0.5,Tween.TRANS_LINEAR)
	tween_tp.start()
	yield(tween_tp, "tween_all_completed")

func _on_eye_thrown(eye):
	reyna_eye = eye
	blind_type = eye.blind_type
#	var current_value = stencil.get_shader_param("beer_factor")
#	tween_tp.interpolate_method(self,"interpolate_reyna_orb_effect", current_value, 1.5, 0.5,Tween.TRANS_LINEAR)
#	tween_tp.start()
#	yield(tween_tp,"tween_all_completed")

func interpolate_reyna_orb_effect(value):
	stencil.set_shader_param("beer_factor", value)


