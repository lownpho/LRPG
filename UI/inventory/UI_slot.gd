extends Panel

export (String, "weapon", "ability", "stock", "throw") var slot_type = "stock"
export (bool) var empty = true

var item := {
	"item_name" : "",
	"item_description" : "",
	"target_slot" : "",
	"path_texture" : "",
	"path_scn" : ""
}


func _ready():
	pass


func get_drag_data(position):
	var tx = TextureRect.new()
	tx.texture = $TextureRect.texture
	set_drag_preview(tx)
	
	return self


func can_drop_data(position, data):
	return empty and (data.item.target_slot == slot_type or slot_type == "stock" or slot_type == "throw")


func drop_data(position, data):
	Events.emit_signal("item_moved", data.item, data.slot_type, slot_type)
	$TextureRect.texture = data.get_node("TextureRect").texture
	fill(data.item)
	data.clear()
	if slot_type == "throw":
		clear()


func fill(item_data) -> void:
	empty = false
	for i in item_data:
		item[i] = item_data[i]
	hint_tooltip = item.item_description


func clear() -> void:
	empty = true
	for i in item:
		item[i] = ""
	$TextureRect.texture = null
	hint_tooltip = ""
