extends VBoxContainer


func _ready():
	Events.connect("stat_changed", self, "_on_stat_changed")


func _on_stat_changed(stat_name, value) -> void:
	match stat_name:
		"max_hp":
			$Hp/ProgressBar.max_value = value
			$Hp/Label.text = "HP: " + str($Hp/ProgressBar.value) + "/" + str($Hp/ProgressBar.max_value)
#		"lv":
#			$Lv/ProgressBar.max_value = pow(value+1, 3)
#			prints("needed from", value, "to", value+1, ":", pow(value+1, 3)-pow(value, 3))
#			$Lv/ProgressBar.min_value = pow(value, 3)
#			$Lv/Label.text = "Lv: " + str(value)
		"curr_hp":
			$Hp/ProgressBar.value = value
			$Hp/Label.text = "HP: " + str($Hp/ProgressBar.value) + "/" + str($Hp/ProgressBar.max_value)
#		"exp":
#			$Lv/ProgressBar.value = value
		
