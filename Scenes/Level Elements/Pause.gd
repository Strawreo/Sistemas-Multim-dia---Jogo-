extends Control

@onready var paused = false

func _ready() -> void:
	hide()
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if paused:
			paused = false
			get_tree().paused = false
			hide() 
		else:
			paused = true
			get_tree().paused = true
			show() 
