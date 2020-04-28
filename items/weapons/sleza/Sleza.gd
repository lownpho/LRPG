extends Weapon

export (float, 0.0, 10, 0.1) var bleed_time = 0.0
export (float, 0.0, 10, 0.1) var bleed_scaling = 0

func _ready():
	pass


func _on_Larma_body_entered(body):
	print(_calculate_dmg())
	if body.has_method("take_damage"):
		body.take_damage(_calculate_dmg())
	if body.has_method("bleed"):
		body.bleed(bleed_time, _calculate_dmg()*bleed_scaling)
