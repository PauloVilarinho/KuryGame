extends Node2D


func _ready():
	$AnimationPlayer.play("Text")
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_shuriken"):
		get_tree().change_scene("res://Game.tscn")