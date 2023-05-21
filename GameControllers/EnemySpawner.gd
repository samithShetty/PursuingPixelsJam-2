extends Node

@export var factor: float
@export var map : TileMap
@onready var timer = $Timer
var enemy_types: Array[Resource] = []
var score: int;

func _ready(): 
	## Load all enemy scenes from the Enemy directory
	var enemy_dir = "res://Actors/Enemies/" 
	var enemy_paths = DirAccess.get_files_at(enemy_dir)
	for path in enemy_paths:
		if path.ends_with(".tscn"):
			enemy_types.append(load(enemy_dir + path))


func spawn_enemy():
	var quantity = randi_range(1, int(factor))
	for i in range(quantity):
		var enemy = enemy_types.pick_random().instantiate()
		enemy.position = map.get_used_cells_by_id(0,-1, Vector2i(1,4)).pick_random()
		add_child(enemy)
		enemy.enemy_death.connect(_on_enemy_death.bind(enemy.points))


func _on_enemy_death(points: int):
	score += points

func _on_timer_timeout():
	spawn_enemy()
