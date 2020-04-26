extends VBoxContainer


func _ready():
	Events.connect("stat_changed", self, "_on_stat_changed")


func _on_stat_changed(stat_name, value) -> void:
	match stat_name:
		"max_hp":
			$Hp/ProgressBar.max_value = value
			$Hp/Label.text = "HP: " + str($Hp/ProgressBar.value) + "/" + str($Hp/ProgressBar.max_value)
		"max_mp":
			$Mp/ProgressBar.max_value = value
			$Mp/Label.text = "MP: " + str($Mp/ProgressBar.value) + "/" + str($Mp/ProgressBar.max_value)
		"curr_hp":
			$Hp/ProgressBar.value = value
			$Hp/Label.text = "HP: " + str($Hp/ProgressBar.value) + "/" + str($Hp/ProgressBar.max_value)
		"curr_mp":
			$Mp/ProgressBar.value = value
			$Mp/Label.text = "MP: " + str($Mp/ProgressBar.value) + "/" + str($Mp/ProgressBar.max_value)
		
