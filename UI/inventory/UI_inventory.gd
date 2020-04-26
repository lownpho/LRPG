extends VBoxContainer


func _ready():
	Events.connect("item_dropped", self, "_on_item_dropped")


func _get_empty_stock() -> Panel:
	var panels = $Stock/HBoxContainer2.get_children()
	for p in panels:
		if p.empty == true:
			return p
	return null


func _on_item_dropped(item_data) -> void:
	var s := _get_empty_stock()
	if s != null:
		s.fill(item_data)
		s.get_node("TextureRect").texture = load(item_data.path_texture)
