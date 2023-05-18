extends Node

var Room
var rooms: Array[Node]
@export var tileSize: int
@export var virtual_width: int 
@export var virtual_height: int 

var attempts:= 0
var cells: Array[Vector2]
var neighbors = [Vector2(0, -1), Vector2(0, 1), Vector2(-1, 0), Vector2(1, 0)]
# Called when the node enters the scene tree for the first time.
func _ready():
	Room = load("res://Scenes/Room.tscn")
	rooms = []
	
	cells = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attempts < 10000:
		#place_rect()
		attempts += 1
	

func place_rect():
	var x = randi_range(0, virtual_width)
	var y = randi_range(0, virtual_height)
	
	var width = randi_range(6, 20)
	var height = randi_range(6, 20)
	
	
	var room = Room.instantiate()
	
	room.color = Color.from_hsv(randf(), randf(), 0.8)
	room.size = Vector2(width*tileSize,height*tileSize)
	room.position = Vector2(x*tileSize,y*tileSize)
	add_child(room)
	
	for r in rooms:
		if room.rect.intersects(r.rect, true):
			room.queue_free()
			return
	rooms.append(room)

	
func flood_fill(cell:Vector2):
	pass

	
