extends State

export (float) var spd_scaling := 0.5

onready var velocity := Vector2.ZERO

func _ready() -> void:
	pass


func unhandled_input(_event: InputEvent) -> void:
	pass


func physics_process(_delta: float) -> void:
	velocity = owner.move_and_slide(owner.stats.get_total("spd")*spd_scaling*owner.dir)


func enter(_msg: Dictionary = {}) -> void:
	owner.dir = Vector2(randi()%3-1,randi()%3-1).normalized()
	owner.skin.anim.play("run")
	owner.vision_area.connect("body_entered", self, "_on_VisionArea_body_entered")
	owner.vision_area.set_deferred("monitoring", true)
	$DirChange.start()


func exit() -> void:
	$DirChange.stop()
	owner.vision_area.disconnect("body_entered", self, "_on_VisionArea_body_entered")
	owner.vision_area.set_deferred("monitoring", false)


func _on_DirChange_timeout():
	owner.dir = Vector2(randi()%3-1,randi()%3-1).normalized()
	owner.skin.update_direction(owner.dir.x)

func _on_VisionArea_body_entered(body):
	_state_machine.transition_to("Pursuit", {"body":body})
