extends Node

onready var weapon_thumbnails = load("res://Items/Database/weapon_thumbnails.png")
onready var ability_thumbnails = load("res://Items/Database/ability_thumbnails.png")
var _path = "res://Items/Database/"

var items := {
}

func _ready():
	var dir = Directory.new()
	if dir.open(_path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print(file_name.get_file())
			if !dir.current_is_dir() and file_name.get_extension()=="tres":
				items[file_name.get_file().left(file_name.length()-5)] = load(_path+file_name.get_file())
			file_name = dir.get_next()

func get_instance(item_name) -> Node2D:
	return items[item_name].scene_pck.instance()


func get_gui_data(item_name) -> Dictionary:
	return {
		"item_name" : item_name,
		"description" : items[item_name].description,
		"target_slot" : items[item_name].target_slot,
		"target_class" : items[item_name].target_class,
		"thumbnail" : items[item_name].thumbnail
	}
