extends TextureButton

func LoadNewGame() -> void:
	get_tree().change_scene_to_file("res://scenes/Game Screen.tscn")
	
func LoadHighScores() -> void:
	get_tree().change_scene_to_file("res://scenes/Game Screen.tscn")

func KillGame() -> void:
	get_tree().quit()
