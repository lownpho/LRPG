extends KinematicBody2D

onready var skin := $Skin
onready var stats := $Stats
onready var agent := GSAISteeringAgent.new()


func _ready():
	yield(owner,"ready")
	stats.global_update()
	stats.increment("fru", 5)
	stats.increment("zug", 5)
	stats.increment("lup", 5)

func _physics_process(delta):
	pass
