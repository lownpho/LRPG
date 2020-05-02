extends Position2D

onready var anim = $AnimationPlayer
onready var sprite = $Sprite


func _ready():
	pass


func update_direction(x):
	if x<-0.1:
		sprite.flip_h = true 
	elif x>0.1:
		sprite.flip_h = false
	
