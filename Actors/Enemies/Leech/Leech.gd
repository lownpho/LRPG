extends KinematicBody2D

export(PackedScene) var damage_hint_scn

onready var stats = $Stats
onready var skin = $Skin
onready var vision_area = $VisionArea
onready var attack_area = $AttackArea


onready var agent := GSAISteeringAgent.new()

var dir := Vector2.ZERO


func _ready():
	pass


func _physics_process(delta):
	pass

func damage(hit:Hit) -> void:
	var dmghint = damage_hint_scn.instance()
	dmghint.text = str(stats.damage(hit))
	add_child(dmghint)


func _on_Stats_dead():
	queue_free()
