class_name BallBullet
extends Area2D

enum State {TRAVELLING, EXPLODING}

export (int) var life_range = 5
export (int) var speed = 10

export (int) var damage_mean = 20
export (int) var damage_delta = 5
export (bool) var ignore_armor = false
export (bool) var bleeding = false
export (int) var bleeding_percent = 0
export (int) var bleeding_ticks = 0

var direction := Vector2.ZERO
var _state = "travelling"


func _ready():
	life_range *= Info.tile_size
	speed *= Info.tile_size
	rotation = direction.angle() + PI/2
	
	$Lifetime.wait_time = float(life_range)/float(speed)
	$Lifetime.start()
	rotation = direction.angle() + PI/2


func _physics_process(delta):
	translate(direction*speed*delta)


func _on_Lifetime_timeout():
	if _state == "travelling":
		_state = "exploding"
		$AnimationPlayer.play("explode")
		speed = 0


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		queue_free()


func _on_BallBullet_body_entered(body):
	if _state == "travelling":
		_state = "explode"
		$AnimationPlayer.play("explode")
		speed = 0
	
	if body.has_method("damage"):
		body.damage(Hit.new(damage_mean, damage_delta, ignore_armor, bleeding, bleeding_percent, bleeding_ticks))
	else:
		prints(body.name, "does not have damage method!")
