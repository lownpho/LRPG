extends Node

var active_items = {}
#var stock = {}

func _ready():
	Events.connect("item_moved", self, "_on_item_moved")
	Events.connect("item_dropped", self, "_on_item_dropped")
	pass


func stock(item_data) -> void:
	pass


func trash(item_data) -> void:
	pass


func _on_item_moved(msg) -> void:
	print(msg)
	if msg.slot_from == "stock":
		if msg.slot_to == "weapon" or msg.slot_to == "armor":
			var item = ItemDb.get_instance(msg.item_name)
			active_items[msg.item_name] = item
			get_parent().add_child(item)
		elif msg.slot_to == "ability":
			var item = ItemDb.get_instance(msg.item_name)
			item.binding = msg.binding
			active_items[msg.item_name] = item
			get_parent().add_child(item)
	elif (msg.slot_from == "weapon" or msg.slot_from == "ability" or msg.slot_from == "armor") and msg.slot_to == "stock":
		active_items[msg.item_name].queue_free()
		active_items.erase(msg.item_name)
	elif msg.slot_from == "ability" and msg.slot_to == "ability":
			active_items[msg.item_name].binding = msg.binding

func _on_item_dropped(item_data):
	pass
