class_name Staff
extends Node2D

export (float, 0.0, 2.0, 0.1) var cooldown
export (PackedScene) var bullet_scn

var _can_attack = true

onready var player = get_parent()

func _ready():
	$Cd.wait_time = cooldown


func _physics_process(delta):
	if Input.is_action_pressed("attack") and _can_attack:
		_attack()


func _attack() -> void:
	_can_attack = false
	$Cd.start()

	var d = player.global_position.direction_to(get_global_mouse_position())
	var bullet = bullet_scn.instance()
	bullet.direction = d
	bullet.position = global_position
	player.get_parent().add_child(bullet)


func _on_Cd_timeout():
	_can_attack = true
