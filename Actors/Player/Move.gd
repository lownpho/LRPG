extends PlayerState

var speed : int
var dir := Vector2.ZERO
var direction := Vector2.ZERO
var velocity := Vector2.ZERO


func _ready() -> void:
	yield(owner, "ready")
	speed = player.stats.get_total("spd")
	Events.connect("stat_modded", self, "_on_stat_modded")

func unhandled_input(_event: InputEvent) -> void:
	pass


func physics_process(_delta: float) -> void:
	dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	dir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	velocity = player.move_and_slide(dir.normalized() * speed)
	update_agent()
	
	if velocity.length() != 0:
		player.skin.anim.play("run")
		player.skin.update_direction(dir.x)
	else: 
		player.skin.anim.play("idle")


func enter(_msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func update_agent() -> void:
	player.agent.position.x = player.global_position.x
	player.agent.position.y = player.global_position.y
	player.agent.linear_velocity.x = velocity.x
	player.agent.linear_velocity.y = velocity.y

func _on_stat_modded(stat_name, stat_value) -> void:
	match stat_name:
		"spd":
			speed = stat_value
