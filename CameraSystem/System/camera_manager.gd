class_name CameraManager
extends Node

@export var CameraList: Array[CameraBase] = []
var CurrentCamera: CameraBase = null

func ActiveCamera(NewCamera: CameraBase) -> void:
	if NewCamera == null:
		return
	
	if CurrentCamera:
		CurrentCamera.Uncontrolled()
	
	CurrentCamera = NewCamera
	NewCamera.ControlledBy()

func TryActiveCameraByIndex(Index: int) -> void:
	if Index < 0:
		return
	
	if Index > CameraList.size() - 1:
		return
	
	ActiveCamera(CameraList[Index])

func _ready() -> void:
	TryActiveCameraByIndex(0)

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_1):
		TryActiveCameraByIndex(0)
	elif Input.is_key_pressed(KEY_2):
		TryActiveCameraByIndex(1)
	elif Input.is_key_pressed(KEY_3):
		TryActiveCameraByIndex(2)
	elif Input.is_key_pressed(KEY_4):
		TryActiveCameraByIndex(3)
	elif Input.is_key_pressed(KEY_5):
		TryActiveCameraByIndex(4)
	elif Input.is_key_pressed(KEY_6):
		TryActiveCameraByIndex(5)
	elif Input.is_key_pressed(KEY_7):
		TryActiveCameraByIndex(6)
	elif Input.is_key_pressed(KEY_8):
		TryActiveCameraByIndex(7)
	elif Input.is_key_pressed(KEY_9):
		TryActiveCameraByIndex(8)
	elif Input.is_key_pressed(KEY_0):
		TryActiveCameraByIndex(9)
