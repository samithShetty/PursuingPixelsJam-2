extends Node2D
@export var attackSpeed: float = 0.2
@export var swingArc: float = 40
var attacking := false
var elapsed_time: float
var start_rotation: float
var swing_dir: int
var tween: Tween


func start_attack():
	attacking = true
	elapsed_time = 0
	start_rotation = rotation_degrees
	swingArc *= [1,-1].pick_random()
	tween = create_tween()
	

func _process(delta):
	if elapsed_time > attackSpeed:
		attacking = false;
	if attacking:
		rotation_degrees = tween.interpolate_value(start_rotation+swingArc, swingArc*-2, elapsed_time, attackSpeed,Tween.TRANS_BACK,Tween.EASE_OUT)
	elapsed_time += delta
