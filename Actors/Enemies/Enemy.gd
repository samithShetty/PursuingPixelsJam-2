class_name Enemy
extends CharacterBody2D

enum EnemyState {IDLE,CHASE,ATTACK} 
signal enemy_death

@onready var weapon = $Weapon
@onready var anim = $AnimatedSprite2D

@export var player: Node2D

@export var detection_radius: float
@export var attack_radius: float
@export var move_speed: float
@export var max_health: float
@export var points: float

var enemyState: EnemyState
var health: float
var roam_point: Vector2 = Vector2.ZERO
var timer: float

func _ready():
	enemyState = EnemyState.IDLE
	health = max_health
	player = get_node("/root/Main/Player")
	z_index = 3

func _physics_process(delta):
	if player.position.distance_to(self.position) < attack_radius:
		enemyState = EnemyState.ATTACK
	elif player.position.distance_to(self.position) < detection_radius:
		enemyState = EnemyState.CHASE
	else:
		enemyState = EnemyState.IDLE
	
	match enemyState:
		EnemyState.IDLE:
			roam(delta)
		EnemyState.CHASE:
			chase()
		EnemyState.ATTACK:
			if not weapon.attacking:
				attack()

func move(target, speed):
	#self.position = self.position.move_toward(target, speed)
	velocity = (target-self.position).normalized() * speed
	move_and_slide()
	anim.flip_h = target.x < self.position.x
	anim.play("run")

func roam(delta_time):
	if roam_point != Vector2.ZERO:
		move(roam_point, move_speed*0.5)
		if self.position.distance_squared_to(roam_point) < 100:
			roam_point = Vector2.ZERO
			anim.play("idle")
			timer = randf_range(2.0,5.0)
	else:
		if timer <= 0:
			roam_point = self.position + Vector2(randf_range(-500, 500), randf_range(-500, 500)) #TODO: Verify Point
		timer -= delta_time

func chase(): # Overridden by Ranged Enemies
	roam_point = Vector2.ZERO
	move(player.position, move_speed)
	anim.play("run")

func attack(): ## This gets overridden in enemy subclasses
	anim.play("idle") 
	weapon.rotation = get_angle_to(player.position)
	weapon.start_attack()


func update_health(delta_health): # Negative to Damage
	health += delta_health
	if health <= 0:
		emit_signal("enemy_death")
		queue_free()

