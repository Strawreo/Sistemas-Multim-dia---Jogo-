extends Control

func _ready() -> void:
	z_index = 10
	$Credits.z_index = 5
	$Credits.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Credits.hide()

func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Level_1.tscn")


func _on_credits_pressed() -> void:
	$Credits.show()
	$Credits.z_index = 20
	$Credits.mouse_filter = Control.MOUSE_FILTER_STOP
	$Credits/VBoxContainer/Volta.grab_focus()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_volta_pressed() -> void:
	$Credits.hide()
	$Credits.z_index = 5
	$Credits.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$HBoxContainer/Start.grab_focus()
