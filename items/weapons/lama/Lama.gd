extends Area2D

export var scalings := {"fru":0.3, "zug":0.3, "lup":0.3}
var can_attack := true

onready var player = get_parent()

func _ready():
	pass


func _physics_process(delta):
	if Input.is_action_pressed("attack") and can_attack:
		_attack()


func _attack() -> void:
	monitoring = true
	can_attack = false
	$Cd.start()
	$Uptime.start()
	$AnimationPlayer.play("attack")

	var d = player.global_position.direction_to(get_global_mouse_position())
	rotation = d.angle() + PI/2


func _calculate_dmg() -> int:
	var d := 0.0
	for s in scalings:
		d += player.stats.get_total(s) * scalings[s]
	return int(round(d))


func _on_cd_timeout():
	can_attack = true


func _on_uptime_timeout():
	monitoring = false


func _on_Lama_body_entered(body):
	print(body.name)
	print(_calculate_dmg())
	if body.has_method("take_damage"):
		body.take_damage(_calculate_dmg())
