extends Weapon

export (float, 0.0, 1, 0.1) var knock_amount := 0.0

func _ready():
	pass


func _on_Ghizine_body_entered(body):
	print(_calculate_dmg())
	if body.has_method("take_damage"):
		body.take_damage(_calculate_dmg())
	if body.has_method("knock"):
		body.knock(knock_amount)
