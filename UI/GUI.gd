extends Control


@export var player: Node;
@export var penaltyController: Node

@export var HealthBar: ProgressBar;
@export var HungerBar: ProgressBar;
@export var EnergyBar: ProgressBar;
@export var PenaltyTimer: TextureProgressBar;

var start_position
# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = player.position;
	set_stats()

func _process(delta):
	set_stats()
	PenaltyTimer.value = penaltyController.timer.time_left/penaltyController.penalty_duration*100

func set_stats():
	HealthBar.max_value = player.maxHealth
	HealthBar.value = player.health

	HungerBar.max_value = player.maxHunger
	HungerBar.value = player.hunger

	EnergyBar.max_value = player.maxEnergy
	EnergyBar.value = player.energy

func update_penalty_icon(icon_path):
	var icon = load(icon_path)
	PenaltyTimer.texture_under = icon 
	PenaltyTimer.texture_progress = icon 

