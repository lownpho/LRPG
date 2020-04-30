extends KinematicBody2D

onready var skin := $Skin
onready var stats := $Stats
onready var agent := GSAISteeringAgent.new()

export (String, "knight", "wizard", "assassin") var class_type = "wizard"

func _ready():
	randomize()
	yield(owner,"ready")
	Info.player_class = class_type
	stats.global_update()

func _physics_process(delta):
	pass
