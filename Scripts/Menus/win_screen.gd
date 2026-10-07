extends Control

func _ready() -> void:
	hide()


func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	get_tree().paused = true
	show() 
	$VBoxContainer/HBoxContainer/NextLevel.grab_focus()


func _on_next_level_pressed() -> void:
	pass 


func _on_main_menu_pressed() -> void:
	pass 
