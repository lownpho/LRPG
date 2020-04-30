class_name Bullet
extends Area2D

export (int) var life_range = 5
export (int) var speed = 20

export (int) var damage_mean = 1
export (int) var damage_delta = 1
export (bool) var ignore_armor = false
export (bool) var bleeding = false
export (int) var bleeding_percent = 0
export (int) var bleeding_ticks = 0

var direction := Vector2.ZERO

func _ready():
	life_range *= Info.tile_size
	speed *= Info.tile_size
	
	$Lifetime.wait_time = float(life_range)/float(speed)
	$Lifetime.start()
	rotation = direction.angle() + PI/2


func _physics_process(delta):
	translate(direction*speed*delta)


func _on_Lifetime_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	if body.has_method("damage"):
		body.damage(Hit.new(damage_mean, damage_delta, ignore_armor, bleeding, bleeding_percent, bleeding_ticks))
	else:
		prints(body.name, "does not have damage method!")
	queue_free()
