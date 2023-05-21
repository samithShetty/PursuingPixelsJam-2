extends Node
## Controls Starting/Ending of Penalty Events and contains all Event definitions

enum Penalty{RANDOM_CONTROLS,NO_JUMP,NO_ATTACK, ONE_HP}

@export var player: Node2D
@export var gui: Control
@export var enemyController: Node2D

@onready var timer = $Timer

var currentPenalty: Penalty
var penalty_icon_path: String
var penalty_duration: float

func _ready():
	timer.start(1)
	

func roll_penalty():
	currentPenalty = randi_range(0,Penalty.size()-1)
	penalty_duration = 10.0
	

func start_penalty():
	match currentPenalty:
		Penalty.RANDOM_CONTROLS:
			random_controls()
			penalty_icon_path = "res://Assets/Shikashi's Fantasy Icons Pack v2/beer.png"
		Penalty.NO_JUMP:
			no_jump()
			penalty_icon_path = "res://Assets/Shikashi's Fantasy Icons Pack v2/beartrap.png"
		Penalty.NO_ATTACK:
			no_attack()
			penalty_icon_path = "res://Assets/Shikashi's Fantasy Icons Pack v2/heart.png"
		Penalty.ONE_HP:
			one_hp()

	gui.update_penalty_icon(penalty_icon_path)
	timer.start(penalty_duration)


func end_penalty():
	match currentPenalty:
		Penalty.RANDOM_CONTROLS:
			end_random_controls()
		Penalty.NO_JUMP:
			end_no_jump()
		Penalty.NO_ATTACK:
			end_no_attack()
		Penalty.ONE_HP:
			end_one_hp()

func create_input_event(action):
	var event = InputEventKey.new()
	event.keycode = action
	return event
	
func random_controls(): # Player Movement Controls are randomly swapped
	print(InputMap.action_get_events("move_up"))
	# Clear Current Controls
	InputMap.action_erase_events("move_up")
	InputMap.action_erase_events("move_left")
	InputMap.action_erase_events("move_down")
	InputMap.action_erase_events("move_right")
	
	# Add randomized controls
	var controls = [KEY_W,KEY_S,KEY_D,KEY_A]
	var i = randi_range(0,3)
	InputEventAction.new()
	InputMap.action_add_event("move_up",create_input_event(controls[i]))
	InputMap.action_add_event("move_left",create_input_event(controls[(i+1) % 4]))
	InputMap.action_add_event("move_down",create_input_event(controls[(i+2) % 4]))
	InputMap.action_add_event("move_right",create_input_event(controls[(i+3) % 4]))
	
	print(InputMap.action_get_events("move_up"))

func end_random_controls():
	InputMap.action_erase_events("move_up")
	InputMap.action_erase_events("move_left")
	InputMap.action_erase_events("move_down")
	InputMap.action_erase_events("move_right")
	
	# Return Controls to normal
	InputMap.action_add_event("move_up",create_input_event(KEY_W))
	InputMap.action_add_event("move_left",create_input_event(KEY_A))
	InputMap.action_add_event("move_down",create_input_event(KEY_S))
	InputMap.action_add_event("move_right",create_input_event(KEY_D))


func no_jump():
	InputMap.action_erase_events("jump")

func end_no_jump():
	InputMap.action_add_event("jump",create_input_event(KEY_SPACE))


func no_attack():
	InputMap.action_erase_events("attack")

func end_no_attack():
	var event = InputEventMouseButton.new()
	event.button_index = 1
	InputMap.action_add_event("attack",event)


func one_hp():
	player.health = 1
	
func end_one_hp():
	player.health = player.maxHealth


func _on_timer_timeout():
	end_penalty()
	roll_penalty()
	start_penalty()
