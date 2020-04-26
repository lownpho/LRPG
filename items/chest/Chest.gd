extends Area2D

export var content := {
	"item_name" : "Lama",
	"item_description" : "Una lama sgenfa, non farlerebbe nemmeno uno gniripillo",
	"target_slot" : "weapon",
	"path_texture" : "res://items/weapons/lama/sword.png",
	"path_scn" : "res://items/weapons/lama/Lama.tscn"
}


func _ready():
	connect("body_entered", self, "_on_Chest_body_entered")
	connect("body_exited", self, "_on_Chest_body_exited")
	$Content.connect("input_event", self, "_on_Content_input_event" )


func _on_Content_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("attack"):
		Events.emit_signal("item_dropped", content)
		queue_free()


func _on_Chest_body_entered(body):
	$Content.show()
	$AnimationPlayer.play("open")


func _on_Chest_body_exited(body):
	$Content.hide()
	$AnimationPlayer.play("closed")
