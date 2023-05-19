extends Node

@export var factor: float
@export var map : TileMap
@onready var timer = $Timer
var enemy_types: Array[Resource] = []


func _ready(): 
	## Load all enemy scenes from the Enemy directory
	var enemy_dir = "res://Actors/Enemies/" 
	var enemy_paths = DirAccess.get_directories_at(enemy_dir)
	for path in enemy_paths:
		enemy_types.append(load(enemy_dir+path+"/"+path+".tscn"))


func spawn_enemy():
	var quantity = randi_range(1, int(factor))
	for i in range(quantity):
		var enemy = enemy_types.pick_random().instantiate()
		enemy.position = map.get_used_cells_by_id(0,-1, Vector2i(1,4)).pick_random()
		add_child(enemy)
		print(enemy)

func _on_timer_timeout():
	spawn_enemy()
