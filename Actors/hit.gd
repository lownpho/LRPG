class_name Hit
extends Node

var damage := 0
var bleeding_percent := 0
var bleeding_ticks := 0
var lifesteal_percent := 0

var is_armor_ignore := false
var is_bleeding := false
var is_lifesteal := false

func _init(average_damage:int, delta_damage:int, is_armor_ignore:=false, 
	is_bleeding:=false, bleeding_percent:=0, bleeding_ticks:=0,
	is_lifesteal:=false, lifesteal_percent:=0) -> void:
	
	self.is_armor_ignore = is_armor_ignore
	self.is_bleeding = is_bleeding
	self.bleeding_ticks = bleeding_ticks
	self.bleeding_percent = bleeding_percent
	self.is_lifesteal = is_lifesteal
	self.lifesteal_percent = lifesteal_percent
	
	damage = randi()%delta_damage - delta_damage/2 + average_damage
