extends Node2D

export(Array, Vector2) var points
var ponto_atual = 0
var ponto_proximo = 1
export var speed = 300
var movendo = true
var x
onready var enemyBody = get_node("EnemyBody")
onready var timer = get_node("Timer")
onready var raycast = get_node("EnemyBody/RayCast2D")
onready var player = get_parent().get_parent().get_node("Player/PlayerBody")
var ray = false
var is_dead = false


func _ready():
	x = points[ponto_proximo] - points[ponto_atual]
	x = x.normalized()
	set_process(true)


# warning-ignore:unused_argument
func _process(delta):
	if not is_dead:
		if ray:
			change_rotation(player)
			if raycast.is_colliding():
				if raycast.get_collider() == player :
					player.die()
				
		if movendo:
			enemyBody.get_node("AnimatedSprite").play("walk")
			enemyBody.move_and_slide(x * speed)
			enemyBody.rotation_degrees = rad2deg(x.angle()) - 90
			if enemyBody.position.distance_to(points[ponto_proximo]) < 8 :
				ponto_atual = ponto_proximo
				ponto_proximo += 1
				if points.size() == ponto_proximo:
					ponto_proximo = 0
				enemyBody.get_node("AnimatedSprite").play("idle")
				movendo = false
				x = points[ponto_proximo] - points[ponto_atual]
				x = x.normalized()
				timer.start()
			
			
			
	else:
		die()
		

func die():
	enemyBody.get_node("AnimatedSprite").play("dead")
	enemyBody.get_node("CollisionShape2D").disabled = true
	enemyBody.get_node("Area2D/CollisionPolygon2D").disabled = true
	enemyBody.get_node("Light2D").enabled = false
	if enemyBody.get_node("LightOccluder2D") :
		enemyBody.get_node("LightOccluder2D").queue_free()

func _on_Timer_timeout():
	movendo = true

func _on_Area2D_body_entered(body):
	if body.name == "PlayerBody":
		ray = true
		raycast.cast_to = Vector2(480,0)
		
		
	

func change_rotation(target):
	raycast.rotation_degrees = rad2deg(enemyBody.get_angle_to(target.global_position))


func _on_Area2D_body_exited(body):
	if body.name == "PlayerBody":
		ray = false
