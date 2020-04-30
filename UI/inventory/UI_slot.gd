extends NinePatchRect

export (String, "weapon", "ability", "armor", "stock", "throw") var slot_type = "stock"
export (String, "spellE", "spellQ", "spellR", "") var binding = ""
var empty := true

var content := {
#	"item_name" : "",
#	"description" : "",
#	"target_slot" : "",
#	"target_class" : "",
#	"thumbnail" : ""
}


func _ready():
	match slot_type:
		"weapon":
			region_rect = Rect2(0,0,18,18)
		"ability":
			region_rect = Rect2(18,0,18,18)
		"armor":
			region_rect = Rect2(36,0,18,18)
		"stock":
			region_rect = Rect2(0,18,18,18)
		"throw":
			region_rect = Rect2(18,18,18,18)


func get_drag_data(position):
	var tx = TextureRect.new()
	tx.texture = $TextureRect.texture
	set_drag_preview(tx)
	
	return self


func can_drop_data(position, data):
	var can := false
	match slot_type:
		#are we sure?
		"weapon":
			can = (!data.empty) and (data.content.target_slot == slot_type) and (Info.player_class == data.content.target_class)
		"ability":
			can = (!data.empty) and (data.content.target_slot == slot_type) and (Info.player_class == data.content.target_class)
		"armor":
			can = (!data.empty) and (data.content.target_slot == slot_type) and (Info.player_class == data.content.target_class)
		"stock":
			can = (!data.empty)
		"throw":
			can = (!data.empty)
	return (can and empty)

#redundant!!! but ok.
func drop_data(position, data):
	match slot_type:
		"weapon":
			fill(data.content)
			Events.emit_signal("item_moved", {"slot_from":data.slot_type, "slot_to":slot_type, 
			"item_name":content.item_name})
			data.clear()
		"ability":
			fill(data.content)
			Events.emit_signal("item_moved", {"slot_from":data.slot_type, "slot_to":slot_type, 
			"item_name":content.item_name, "binding":binding})
			data.clear()
		"armor":
			fill(data.content)
			Events.emit_signal("item_moved", {"slot_from":data.slot_type, "slot_to":slot_type, "item_name":content.item_name})
			data.clear()
		"stock":
			fill(data.content)
			Events.emit_signal("item_moved", {"slot_from":data.slot_type, "slot_to":slot_type, 
			"item_name":content.item_name})
			data.clear()
		"throw":
#			Events.emit_signal("item_moved", {"slot_from":data.slot_type, "slot_to":slot_type, 
#			"item_name":content.item_name})
			data.clear()

func fill(new_content) -> void:
	empty = false
	for i in new_content:
		content[i] = new_content[i]
	$TextureRect.texture = content.thumbnail
	hint_tooltip = content.description


func clear() -> void:
	empty = true
	content.clear()
	$TextureRect.texture = null
	hint_tooltip = ""
