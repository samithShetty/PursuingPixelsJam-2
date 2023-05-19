extends Weapon

@export var projectile_path: String

@onready var projectile = load(projectile_path)
@onready var anim = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func start_attack():
	attacking = true
	elapsed_time = 0
	anim.play("attack")

func fire():
	var proj = projectile.instantiate()
	proj.top_level = true
	proj.global_position = self.global_position
	proj.global_rotation_degrees = self.global_rotation_degrees
	add_child(proj)
	proj.start_attack()
	


func _on_animated_sprite_animation_finished():
	fire()
