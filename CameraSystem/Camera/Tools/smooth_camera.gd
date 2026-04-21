class_name SmoothCamera
extends CameraBase

signal smooth_finished(NewCamera: CameraBase)

var smooth_duration: float = 1.0
var curve: Curve

var is_smoothing: bool = false
var current_timer: float = 0.0
var from_camera: CameraBase
var to_camera: CameraBase

func _ready() -> void:
	current = false

# 根据时间进行平滑过渡
func smooth_by_time(from_cam: CameraBase, to_cam: CameraBase, duration: float = -1.0) -> void:
	if !_validate_cameras(from_cam, to_cam):
		return
	
	from_camera = from_cam
	to_camera = to_cam
	smooth_duration = duration if duration > 0 else smooth_duration
	_start_smooth()

# 验证相机有效性
func _validate_cameras(from_cam: CameraBase, to_cam: CameraBase) -> bool:
	if !to_cam:
		smooth_finished.emit(to_cam)
		return false
	
	if !from_cam:
		global_transform = to_cam.global_transform
		smooth_finished.emit(to_cam)
		return false
	
	return true

# 开始平滑过渡
func _start_smooth() -> void:
	_sync_camera_properties(from_camera)
	current_timer = 0.0
	is_smoothing = true
	current = true

# 同步相机属性
func _sync_camera_properties(source_cam: CameraBase) -> void:
	fov = source_cam.fov
	near = source_cam.near
	far = source_cam.far
	h_offset = source_cam.h_offset
	v_offset = source_cam.v_offset

func _process(delta: float) -> void:
	if !is_smoothing:
		return
	
	current_timer += delta
	var t = current_timer / smooth_duration
	
	if t >= 1.0:
		_finish_smooth()
	else:
		var lerp_factor = t
		if curve and curve.has_method("sample"):
			lerp_factor = curve.sample(t)
		
		global_transform = from_camera.global_transform.interpolate_with(
			to_camera.global_transform, lerp_factor
		)
		_sync_interpolated_properties(lerp_factor)

# 同步并插值相机属性
func _sync_interpolated_properties(t: float) -> void:
	if !from_camera or !to_camera:
		return
	fov = lerp(from_camera.fov, to_camera.fov, t)

# 结束平滑过渡
func _finish_smooth() -> void:
	is_smoothing = false
	current = false
	smooth_finished.emit(to_camera)

# 获取当前平滑进度
func get_smooth_progress() -> float:
	if !is_smoothing:
		return 1.0
	return current_timer / smooth_duration

# 取消当前平滑过渡
func cancel_smooth() -> void:
	if is_smoothing:
		_finish_smooth()
