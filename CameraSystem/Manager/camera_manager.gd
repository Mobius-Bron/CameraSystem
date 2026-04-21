class_name CameraManager
extends Node

enum CurrentState {
	None,
	Smoothing
}

@onready var smooth_camera: SmoothCamera = $SmoothCamera

@export var CameraList: Array[CameraBase] = []
@export var smooth_time: float = 1.0
@export var curve: Curve = null

var CurrentCamera: CameraBase = null
var CameraState: CurrentState = CurrentState.None
	
func ActiveCamera(NewCamera: CameraBase) -> void:
	if NewCamera == null: return
	if NewCamera == CurrentCamera : return
	if CameraState == CurrentState.Smoothing: return
	
	CameraState = CurrentState.Smoothing
	
	if CurrentCamera: CurrentCamera.Uncontrolled()
	
	smooth_camera.ControlledBy()
	smooth_camera.smooth_by_time(CurrentCamera, NewCamera)

func on_smooth_finish(NewCamera: CameraBase) -> void:
	NewCamera.ControlledBy()
	CurrentCamera = NewCamera
	
	CameraState = CurrentState.None

func TryActiveCameraByIndex(Index: int) -> void:
	if Index < 0:
		return
	
	if Index > CameraList.size() - 1:
		return
	
	ActiveCamera(CameraList[Index])

func _ready() -> void:
	smooth_camera.smooth_duration = self.smooth_time
	smooth_camera.curve = self.curve
	smooth_camera.smooth_finished.connect(on_smooth_finish)
	
	TryActiveCameraByIndex(0)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1: TryActiveCameraByIndex(0)
			KEY_2: TryActiveCameraByIndex(1)
			KEY_3: TryActiveCameraByIndex(2)
			KEY_4: TryActiveCameraByIndex(3)
			KEY_5: TryActiveCameraByIndex(4)
			KEY_6: TryActiveCameraByIndex(5)
			KEY_7: TryActiveCameraByIndex(6)
			KEY_8: TryActiveCameraByIndex(7)
			KEY_9: TryActiveCameraByIndex(8)
			KEY_0: TryActiveCameraByIndex(9)
