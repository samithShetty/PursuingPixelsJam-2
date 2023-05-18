extends RigidBody2D

@export var moveSpeed: float = 5
@export var maxHealth: float = 5
@export var maxHunger: float = 5
@export var maxEnergy: float = 5

var anim: AnimationPlayer;
var sprite: Sprite2D;

var health = 4;
var hunger = 5;
var energy = 5;
var jumping: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = $AnimationPlayer
	sprite = $KnightSpritesheet


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	## PLAYER MOVEMENT
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		sprite.flip_h = false
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		sprite.flip_h = true
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	position += velocity.normalized() * moveSpeed;
	
	## ANIMATION HANDLING
	if jumping:
		anim.play("jump")
	elif velocity != Vector2.ZERO:
		anim.play("run")
	else:
		anim.play("idle")
	
func _unhandled_key_input(event):
	if event.is_action_pressed("jump") and not jumping:
		anim.play("jump");
		jumping = true;
		scale = Vector2(1.5,1.5)
	
func end_jump():
	jumping = false;
	scale = Vector2(1,1)
	
	
func update_health(delta_health): # Negative to damage player
	health += delta_health
	
func update_hunger(delta_hunger): # Negative to reduce hunger
	hunger += delta_hunger
	
func update_energy(delta_energy): # Negative to reduce energy
	energy += delta_energy
	
