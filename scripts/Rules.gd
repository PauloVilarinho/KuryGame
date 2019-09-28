extends Node2D

export var time = 5
onready var timer = get_node("Timer")

func _ready():
	timer.wait_time = time
	timer.start()
	set_process(true)


func _process(delta):
	get_node("Camera2D/Time").text = "Timer" + " : " +str(int(timer.time_left))
	get_node("Camera2D/Ammo/Label").text = "X " + str($Player.get_node("PlayerBody").ammo)
	get_node("Camera2D/Bombs/Label2").text = "X " + str($Player.get_node("PlayerBody").lifes)

func _on_Timer_timeout():
	get_tree().change_scene('res://menus/scenes/GameOver.tscn')


func _on_Level1_body_entered(body):
	if body.name == "PlayerBody":
		get_node("Camera2D/AnimationPlayer").play("level1")
		$CheckPoint.position = get_node("Level1").position + Vector2(50,0)
		get_node("Level1/CollisionShape2D").queue_free()
		body.reload(1)
		


func _on_Level2_body_entered(body):
	if body.name == "PlayerBody":
		get_node("Camera2D/AnimationPlayer").play("level2")
		$CheckPoint.position = get_node("Level2").position + Vector2(50,0)
		get_node("Level2/CollisionShape2D").queue_free()
		body.reload(1)


func _on_Level3_body_entered(body):
	if body.name == "PlayerBody":
		get_node("Camera2D/AnimationPlayer").play("level3")
		$CheckPoint.position = get_node("Level3").position + Vector2(50,0)
		get_node("Level3/CollisionShape2D").queue_free()
		body.reload(1)
