class_name Weapon

extends Area2D

export (int) var base_damage = 0

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


#IMPLEMENT _ON_BODY_ENTER IN CHILD CLASSES!!


func _on_cd_timeout():
	can_attack = true


func _on_uptime_timeout():
	monitoring = false

