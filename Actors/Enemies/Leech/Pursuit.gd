extends State

export var speed_scaling := 1.0
var acceleration_max := 50000

var velocity := Vector2.ZERO
var linear_drag := 0.1

var acceleration := GSAITargetAcceleration.new()

onready var agent := GSAISteeringAgent.new()
onready var player_agent: GSAISteeringAgent

onready var proximity
onready var blend := GSAIBlend.new(agent)
onready var priority := GSAIPriority.new(agent)

var body

func _ready():
	yield(owner,"ready")
	agent.linear_speed_max = owner.stats.get_total("spd")*speed_scaling
	agent.linear_acceleration_max = acceleration_max
	agent.bounding_radius = 32

func unhandled_input(_event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	update_agent()
	
	blend.calculate_steering(acceleration)
	
	#apply drag to slow down, apply final movement, move
	velocity = (velocity + Vector2(acceleration.linear.x, acceleration.linear.y) * delta).clamped(agent.linear_speed_max)
	velocity = velocity.linear_interpolate(Vector2.ZERO, linear_drag)
	velocity = owner.move_and_slide(velocity)
	
	owner.dir = velocity.normalized()
	owner.skin.update_direction(owner.dir.x)


func enter(_msg: Dictionary = {}) -> void:
	owner.attack_area.connect("body_entered", self, "_on_AttackArea_body_entered")
	owner.attack_area.set_deferred("monitoring", true)
	
	player_agent = _msg.body.agent
	update_agent()
	
	proximity = GSAIRadiusProximity.new(agent, build_agent_array(), 128)
	var pursue := GSAIPursue.new(agent, player_agent)
	pursue.predict_time_max = .1
	
	var separation = GSAISeparation.new(agent, proximity)
	separation.decay_coefficient = 512
	blend.add(pursue, 1)
	blend.add(separation, 512)

func exit() -> void:
	owner.attack_area.disconnect("body_entered", self, "_on_AttackArea_body_entered")
	owner.attack_area.set_deferred("monitoring", false)
	$Tire.start()


func update_agent() -> void:
	agent.position.x = owner.global_position.x
	agent.position.y = owner.global_position.y
	agent.linear_velocity.x = velocity.x
	agent.linear_velocity.y = velocity.y


func build_agent_array() -> Array:
	var prox := []
	for n in get_tree().get_nodes_in_group("enemy"):
		prox.push_back(n.find_node("Pursuit").agent)
	return prox


func _on_AttackArea_body_entered(body):
	_state_machine.transition_to("Attack", {"target":body.global_position})


func _on_Tire_timeout():
	_state_machine.transition_to("Patrol")
