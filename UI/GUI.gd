extends Control

@export var player: Node;
@export var HealthBar: ProgressBar;
@export var HungerBar: ProgressBar;
@export var EnergyBar: ProgressBar;

var start_position
# Called when the node enters the scene tree for the first time.
func _ready():
	HealthBar.max_value = player.maxHealth
	HealthBar.value = player.health

	HungerBar.max_value = player.maxHunger
	HungerBar.value = player.hunger

	EnergyBar.max_value = player.maxEnergy
	EnergyBar.value = player.energy
	
	start_position = player.position;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
