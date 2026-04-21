class_name FreeCamera
extends CameraBase

@export_range(0.0, 30.0)var MoveSpeed: float = 10.0
@export_range(0.0, 3.0) var RotationSpeed: float = 1.0

var Pitch: float = 0.0   # 上下角度
var Yaw: float = 0.0     # 左右角度

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if !BeContolled:
		return
	
	print("Hello")
	## 玩家输入部分
	var input_dir: Vector3 = Vector3.ZERO
	
	if Input.is_key_pressed(KEY_W):
		input_dir.z -= 1
	if Input.is_key_pressed(KEY_S):
		input_dir.z += 1
	if Input.is_key_pressed(KEY_A):
		input_dir.x -= 1
	if Input.is_key_pressed(KEY_D):
		input_dir.x += 1
	if Input.is_key_pressed(KEY_Q):
		input_dir.y += 1
	if Input.is_key_pressed(KEY_E):
		input_dir.y -= 1
	
	transform.origin += input_dir.normalized() * MoveSpeed * _delta

func _input(event: InputEvent) -> void:
	if !BeContolled:
		return
	
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		Yaw -= event.relative.x * RotationSpeed
		Pitch -= event.relative.y * RotationSpeed
		
		Pitch = clamp(Pitch, -90.0, 90.0)
		
		rotation = Vector3(deg_to_rad(Pitch), deg_to_rad(Yaw), 0)
