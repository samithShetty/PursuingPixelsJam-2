extends Control

@export var MainScene: Resource
@export var StartScene: Resource

func _start_button_pressed():
	get_tree().change_scene_to_packed(MainScene)


func _quit_button_pressed():
	get_tree().quit()


func _return_button_pressed():
	get_tree().change_scene_to_packed(StartScene)
