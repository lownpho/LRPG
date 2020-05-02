extends Area2D

export (int) var damage_mean = 2
export (int) var damage_delta = 3
export (bool) var ignore_armor = false
export (bool) var bleeding = false
export (int) var bleeding_percent = 0
export (int) var bleeding_ticks = 0

func _ready():
	pass


func _on_FangAttack_body_entered(body):
	if body.has_method("damage"):
		body.damage(Hit.new(damage_mean, damage_delta, ignore_armor, bleeding, bleeding_percent, bleeding_ticks))


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
