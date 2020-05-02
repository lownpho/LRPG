extends Node

export var base := {
	"max_hp" : 5,
	"curr_hp" : 5,
	"spd" : 100,
	"def" : 0,
}
var mods := {} #template {"velocizza" : { "spd" : 22, "max_mp" : 20}, "difendi".....}

var bleeding_queue = []

func _ready():
	pass


func increment(stat_name:String, increment:=1) -> void:
	base[stat_name] += increment
	Events.emit_signal("stat_changed", stat_name, base[stat_name])


func decrement(stat_name:String, decrement:=1) -> void:
	base[stat_name] -= decrement
	Events.emit_signal("stat_changed", stat_name, base[stat_name])


func get_total(stat_name:String) -> int:
	var tot = base[stat_name]
	for n in mods:
		if mods[n].has(stat_name):
			tot += mods[n][stat_name]
	return tot


func add_mod(mod_name:String, mod:Dictionary) -> void:
	mods[mod_name] = mod
	for s in mod:
		Events.emit_signal("stat_modded", s, get_total(s))


func remove_mod(mod_name:String) -> void:
	if mods.has(mod_name):
		var updates = []
		for n in mods[mod_name]:
			updates.push_back(n)
		mods.erase(mod_name)
		for n in updates:
			Events.emit_signal("stat_modded", n , get_total(n))


func heal(amount:=1) -> void:
	var remaining : int = base["max_hp"]-base["curr_hp"]
	if remaining != 0:
		increment("curr_hp", int(clamp(amount, 0, remaining)))


func damage(hit : Hit) -> void:
	var d := 0.0
	if hit.is_armor_ignore:
		d = hit.damage
	else:
		d = clamp(hit.damage-get_total("def"), hit.damage*0.8, hit.damage)
	decrement("curr_hp", int(d))
	
	if hit.is_lifesteal:
		heal(d*hit.lifesteal/100)
	
	if hit.is_bleeding:
		bleeding_queue = []
		for i in range(hit.bleeding_ticks):
			bleeding_queue.push_back(d*hit.bleeding_percent/100)

func global_update() -> void:
	for s in base:
		Events.emit_signal("stat_changed", s, base[s])


func _on_Bleed_timeout():
	var d = bleeding_queue.pop_front()
	if d != null:
		print("tick")
		decrement("curr_hp", d)
