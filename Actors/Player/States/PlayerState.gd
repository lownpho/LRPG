class_name PlayerState
extends State

var player: KinematicBody2D


func _ready() -> void:
	yield(owner, "ready")
	player = owner
