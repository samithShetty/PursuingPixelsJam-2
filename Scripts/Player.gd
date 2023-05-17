extends Node2D

@export var moveSpeed = 5
@export var maxHealth = 5
@export var maxHunger = 5
@export var maxEnergy = 5

var health = 4
var hunger = 5
var energy = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	position += velocity.normalized() * moveSpeed;
	

func update_health(delta_health): # Negative to damage player
	health += delta_health
	
func update_hunger(delta_hunger): # Negative to reduce hunger
	hunger += delta_hunger
	
func update_energy(delta_energy): # Negative to reduce energy
	energy += delta_energy
	
