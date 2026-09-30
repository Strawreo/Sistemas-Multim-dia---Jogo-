extends AnimatableBody3D

@export var move_distance: float = 5.0 
@export var move_speed: float = 2.0    

var start_position: Vector3

func _ready() -> void:
	
	start_position = global_position
	
	start_moving()

func start_moving() -> void:
	
	var tween = create_tween().set_loops()
	

	tween.set_trans(Tween.TRANS_SINE)
	
	
	var target_position = start_position + Vector3(0, move_distance, 0)
	
	
	tween.tween_property(self, "global_position", target_position, move_speed)
	
	
	tween.tween_property(self, "global_position", start_position, move_speed)
