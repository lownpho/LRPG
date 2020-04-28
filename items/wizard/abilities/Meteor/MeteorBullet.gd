class_name SparkBullet
extends KinematicBody2D

export (int) var life_range = 128
export (int) var speed = 300

var direction := Vector2.ZERO
var damage := 0
var exploding = false

func _ready():
	$Cd.wait_time = float(life_range)/float(speed)
	$Cd.start()
	rotation = direction.angle()


func _physics_process(delta):
	if !exploding:
		move_and_slide(direction*speed)


func _on_Area2D_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
	else:
		print(body.name)
	explode()

func _on_Cd_timeout():
	explode()


func explode() -> void:
	$AnimationPlayer.play("explode")
	exploding = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		queue_free()
