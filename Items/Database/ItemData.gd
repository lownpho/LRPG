extends Resource
class_name ItemData


export (String) var name := "Dummy Name"
export (String) var description := "Dummy description"
export (String, "weapon", "armor", "ability", "dummy") var target_slot := "dummy"
export (String, "wizard", "knight", "assassin") var target_class := "wizard"
export (PackedScene) var scene_pck
export (Texture) var thumbnail



func _ready():
	pass
