extends Node2D


func _ready():
	$AnimationPlayer.play("text")
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("ui_shuriken"):
		get_tree().change_scene("res://menus/scenes/Menu.tscn")
