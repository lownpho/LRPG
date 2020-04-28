class_name Bullet
extends KinematicBody2D

export (int) var life_range = 128
export (int) var speed = 300

var direction := Vector2.ZERO
var damage := 0

func _ready():
	$Cd.wait_time = float(life_range)/float(speed)
	$Cd.start()
	rotation = direction.angle()


func _physics_process(delta):
	move_and_slide(direction*speed)


func _on_Area2D_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
	else:
		print(body.name)
	queue_free()

func _on_Cd_timeout():
	queue_free()
