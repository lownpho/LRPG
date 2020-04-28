class_name Staff
extends Node2D

export (PackedScene) var bullet_scn = null
export var damage := 0


var can_attack := true

onready var player = get_parent()

func _ready():
	pass


func _physics_process(delta):
	if Input.is_action_pressed("attack") and can_attack:
		_attack()


func _attack() -> void:
	can_attack = false
	$Cd.start()

	var d = player.global_position.direction_to(get_global_mouse_position())
	var bullet = bullet_scn.instance()
	bullet.direction = d
	bullet.position = global_position
	player.get_parent().add_child(bullet)


func _on_Cd_timeout():
	can_attack = true
