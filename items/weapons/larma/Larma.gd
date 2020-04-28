extends Weapon


func _on_Larma_body_entered(body):
	print(_calculate_dmg())
	if body.has_method("take_damage"):
		body.take_damage(_calculate_dmg())
