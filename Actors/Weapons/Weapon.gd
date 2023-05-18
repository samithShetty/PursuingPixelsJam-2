extends Node2D

@export var damage: float = 5;
@export var attackSpeed: float = 0.2
@export var swingArc: float = 40


var attacking := false
var elapsed_time: float
var start_rotation: float
var swing_dir: int
var tween: Tween
var collisions: Dictionary # Effective HashSet for holding onto enemy collisions

func _process(delta):
	if elapsed_time > attackSpeed:
		attacking = false;
	if attacking:
		rotation_degrees = tween.interpolate_value(start_rotation+swingArc, swingArc*-2, elapsed_time, attackSpeed,Tween.TRANS_BACK,Tween.EASE_OUT)
	elapsed_time += delta

func start_attack():
	tween = create_tween()
	attacking = true
	elapsed_time = 0
	start_rotation = rotation_degrees
	swingArc *= [1,-1].pick_random()
	
	# Damage entities already in the hitbox
	for entity in collisions.keys():
		damage_entity(entity)
	
func _area_entered(area):
	if attacking:
		damage_entity(area.get_parent())
	else:
		collisions[area.get_parent()] = null

func _area_exited(area):
	collisions.erase(area.get_parent())
	
func damage_entity(entity):
	print(entity.health)
	entity.update_health(-damage)
