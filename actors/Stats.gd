extends Node

export var base := {
	"fru" : 0,
	"zug" : 0,
	"lup" : 0,
	"max_hp" : 0,
	"max_mp" : 0,
	"curr_hp" : 0,
	"curr_mp" : 0,
	"spd" : 0,
	"def" : 0
}
var mods := {} #template {"velocizza" : { "spd" : 22, "max_mp" : 20}, "difendi".....}


func _ready():
	pass


func increment(stat_name:String, increment:=1) -> void:
	base[stat_name] += increment
	Events.emit_signal("stat_changed", stat_name, base[stat_name])
	match stat_name:
		"fru":
			increment("max_mp", increment)
			heal("mp", increment)
		"zug":
			increment("max_hp", increment)
			heal("hp", increment)
		"lup":
			increment("spd", increment)


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


func heal(stat_name:String, amount:=1) -> void:
	var remaining : int = base["max_"+stat_name]-base["curr_"+stat_name]
	if remaining != 0:
		increment("curr_"+stat_name, int(clamp(amount, 0, remaining)))

func is_consume(amount:=1) -> bool:
	if base.curr_mp < amount:
		return false
	else:
		decrement("curr_mp", amount)
		return true

func damage(damage:=1) -> void:
	decrement("curr_hp", int(clamp(damage-get_total("def"), damage*0.8, damage)))

func global_update() -> void:
	for s in base:
		Events.emit_signal("stat_changed", s, base[s])
