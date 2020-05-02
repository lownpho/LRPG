extends State

export (PackedScene) var attack_scn
export(float, 0.0, 5.0, 0.1) var wait_min = 0.1
export(int, 0.0, 5.0, 0.1) var wait_max = 1.0

var target_position = Vector2.ZERO

func _ready() -> void:
	pass


func unhandled_input(_event: InputEvent) -> void:
	pass


func physics_process(_delta: float) -> void:
	pass


func enter(_msg: Dictionary = {}) -> void:
	target_position = _msg.target
	$Wait.wait_time = rand_range(wait_min, wait_max)
	$Wait.start()



func exit() -> void:
	pass


func _on_Cd_timeout():
	_state_machine.transition_to("Patrol")


func _on_Wait_timeout():
	$Cd.start()
	owner.skin.anim.play("attack")
	print()
	var d = owner.global_position.direction_to(target_position)
	var attack = attack_scn.instance()
	attack.rotation = d.angle()-PI/2
	attack.position = owner.global_position
	owner.get_parent().add_child(attack)
