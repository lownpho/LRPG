extends Node


signal stat_changed(stat_name, stat_value)
signal stat_modded(stat_name, stat_value)
signal dead

signal item_dropped(item_data)
signal item_moved(item_data, old_slot, new_slot)


func _ready():
	pass

