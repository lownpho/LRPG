extends Node

signal dead
export (int) var max_hp = 5
export (int) var def = 0
export (int) var spd = 100

var base := {}
var mods := {} #template {"velocizza" : { "spd" : 22, "max_mp" : 20}, "difendi".....}

var bleeding_queue = []

func _ready():
	base = {
		"max_hp" : max_hp,
		"curr_hp" : max_hp,
		"spd" : spd,
		"def" : def,
		}


func increment(stat_name:String, increment:=1) -> void:
	base[stat_name] += increment


func decrement(stat_name:String, decrement:=1) -> void:
	base[stat_name] -= decrement
	print(owner.name)


func get_total(stat_name:String) -> int:
	var tot = base[stat_name]
	for n in mods:
		if mods[n].has(stat_name):
			tot += mods[n][stat_name]
	return tot


func add_mod(mod_name:String, mod:Dictionary) -> void:
	mods[mod_name] = mod


func remove_mod(mod_name:String) -> void:
	if mods.has(mod_name):
		var updates = []
		for n in mods[mod_name]:
			updates.push_back(n)
		mods.erase(mod_name)


func heal(amount:=1) -> void:
	var remaining : int = base["max_hp"]-base["curr_hp"]
	if remaining != 0:
		increment("curr_hp", int(clamp(amount, 0, remaining)))


func damage(hit : Hit) -> int:
	var d := 0.0
	if hit.is_armor_ignore:
		d = hit.damage
	else:
		d = max(hit.damage-get_total("def"), 0)
	decrement("curr_hp", int(d))
	
	if hit.is_lifesteal:
		heal(d*hit.lifesteal/100)
	
	if hit.is_bleeding:
		bleeding_queue = []
		for i in range(hit.bleeding_ticks):
			bleeding_queue.push_back(d*hit.bleeding_percent/100)
	
	if get_total("curr_hp") <= 0:
		emit_signal("dead")
	return int(d)


func _on_Bleed_timeout():
	var d = bleeding_queue.pop_front()
	if d != null:
		print("tick")
		decrement("curr_hp", d)
