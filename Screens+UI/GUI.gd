extends Control


@export var player: Node;
@export var penaltyController: Node

@export var HealthBar: ProgressBar;
@export var SoulBar: ProgressBar;
@export var EnergyBar: ProgressBar;
@export var PenaltyTimer: TextureProgressBar;
@export var ScoreLabel: Label;

var start_position
# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = player.position;
	set_stats()

func _process(delta):
	set_stats()
	PenaltyTimer.value = penaltyController.timer.time_left/penaltyController.penalty_duration*100
	ScoreLabel.text = str(player.score)
	
func set_stats():
	HealthBar.max_value = player.maxHealth
	HealthBar.value = player.health

	SoulBar.max_value = player.maxSoul
	SoulBar.value = player.soul

	EnergyBar.max_value = player.maxEnergy
	EnergyBar.value = player.energy

func update_penalty_icon(icon_path):
	var icon = load(icon_path)
	PenaltyTimer.texture_under = icon 
	PenaltyTimer.texture_progress = icon 

