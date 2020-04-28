extends Node

var active_items = {}
var stock = {}

func _ready():
	Events.connect("item_moved", self, "_on_item_moved")
	Events.connect("item_dropped", self, "_on_item_dropped")
	pass


func activate(item_data, binding) -> void:
	var item = load(item_data.path_scn).instance()
	if item.has_method("bind"):
		item.bind(binding)
	get_parent().add_child(item)
	active_items[item_data.item_name] = item
	


func deactivate(item_data) -> void:
	active_items[item_data.item_name].queue_free()


func stock(item_data) -> void:
	pass


func trash(item_data) -> void:
	pass

func _on_item_moved(item_data, old_slot, new_slot, binding) -> void:
	prints(item_data.item_name, "moved from", old_slot, "to", new_slot)
	if new_slot == "weapon" or new_slot == "ability":
		activate(item_data, binding)
	elif new_slot == "stock" and old_slot != "stock":
		deactivate(item_data)

func _on_item_dropped(item_data):
	stock(item_data)
