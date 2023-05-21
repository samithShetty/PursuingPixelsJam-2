extends CharacterBody2D

signal player_status_update

@export var moveSpeed: float
@export var maxHealth: float
@export var maxHunger: float
@export var maxEnergy: float

@export var jumpCost: float

@onready var anim = $AnimationPlayer;
@onready var sprite = $KnightSpritesheet
@onready var sword = $Sword
@onready var hitbox = $Area2D

var health;
var hunger;
var energy;
var move_input: Vector2;
var jumping: bool = false;

func _ready():
	health = maxHealth;
	hunger = maxHunger;
	energy = maxEnergy;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_player(delta)
	animate_player()
	if not sword.attacking:
		place_sword()
	
	update_energy(delta * (3 if move_input == Vector2.ZERO else 1))
	update_hunger(-delta)

func move_player(delta):
	move_input = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		move_input.x += 1
	if Input.is_action_pressed("move_left"):
		move_input.x -= 1
	if Input.is_action_pressed("move_down"):
		move_input.y += 1
	if Input.is_action_pressed("move_up"):
		move_input.y -= 1
	velocity = move_input.normalized() * moveSpeed * ((energy/3 + maxEnergy/3)/maxEnergy) * (2 if jumping else 1)*60;
	move_and_slide()#position += velocity


func animate_player():
	if jumping:
		anim.play("jump")
	elif move_input != Vector2.ZERO:
		anim.play("run")
	else:
		anim.play("idle")

	# Make player face mouse position
	sprite.flip_h = get_local_mouse_position().x < 0


func place_sword():
	var angle = get_angle_to(get_local_mouse_position() + position)
	sword.rotation = angle


func _unhandled_input(event):
	if event.is_action_pressed("jump") and not jumping and energy > jumpCost: ## Jump
		anim.play("jump");
		jumping = true;
		energy -= jumpCost
		hitbox.process_mode = Node.PROCESS_MODE_DISABLED


func _input(event):
	if event.is_action_pressed("attack"):
		sword.start_attack()

func end_jump():
	jumping = false;
	scale = Vector2(1,1)
	hitbox.process_mode = Node.PROCESS_MODE_INHERIT

func update_health(delta_health): # Negative to damage player
	health += delta_health
	if health <= 0:
		get_tree().change_scene_to_file("res://Screens+UI/GameOver.tscn")
		
func update_hunger(delta_hunger): # Negative to reduce hunger
	hunger += delta_hunger

	
func update_energy(delta_energy): # Negative to reduce energy
	energy = clampf(energy + delta_energy, 0, maxEnergy)
	
