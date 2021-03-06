extends VBoxContainer


func _ready():
	Events.connect("item_dropped", self, "_on_item_dropped")


func _get_empty_slot(type) -> Panel:
	var slots = get_tree().get_nodes_in_group("slots")
	for s in slots:
		if s.slot_type == type and s.empty == true:
			return s
	return null


func _on_item_dropped(content) -> void:
	var s := _get_empty_slot("stock")
	if s != null:
		s.fill(content)
