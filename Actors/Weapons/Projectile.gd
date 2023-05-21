extends Weapon

@export var flight_speed: float
@export var duration: float
 

# Called when the node enters the scene tree for the first time.
func start_attack():
	attacking = true
	# Damage entities already in the hitbox
	for entity in collisions.keys():
		damage_entity(entity)
	
	await get_tree().create_timer(duration).timeout
	queue_free()
	
	
func _physics_process(delta):
	global_position = flight_speed*Vector2.RIGHT.rotated(rotation)
	
