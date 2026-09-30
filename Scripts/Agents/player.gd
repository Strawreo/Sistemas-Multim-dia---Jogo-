extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var mouse_sensitivity := 0.002
@export var gamepad_sensitivity := 2.5

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

func _ready() -> void:
	#oculta o mouse na tela
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		spring_arm.rotation.y -= event.relative.x * mouse_sensitivity
		spring_arm.rotation.x -= event.relative.y * mouse_sensitivity
		
		#limita o ângulo de visão para impedir um 360
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(-75), deg_to_rad(35))
		
		#pra fechar o jogo, depois mover para o script globals
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	
 #câmera com o controle
	var look_dir := Input.get_vector("look_left", "look_right", "look_up", "look_down")
	if look_dir.length() > 0:
		spring_arm.rotation.y -= look_dir.x * gamepad_sensitivity * delta
		spring_arm.rotation.x -= look_dir.y * gamepad_sensitivity * delta
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(-75), deg_to_rad(35))

	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	#calcula um vetor direção com base na câmera
	var direction := (spring_arm.transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	
	
	direction.y = 0 
	direction = direction.normalized()

	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		var look_angle = atan2(-velocity.x, -velocity.z)
		mesh.rotation.y = lerp_angle(mesh.rotation.y, look_angle, 10 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
