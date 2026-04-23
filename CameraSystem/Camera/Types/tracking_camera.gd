## 镜头追踪摄像机
class_name TrackingCamera
extends CameraBase

@export var TargetNode: Node3D
@export var MovingPathFollow: PathFollow3D
@export_range(0.0, 10.0) var MoveSpeed: float = 2.0
@export var TargetOffest: Vector3

func _ready() -> void:
	if MovingPathFollow != null:
		MovingPathFollow.rotation_mode = PathFollow3D.ROTATION_NONE

func _process(_delta: float) -> void:
	if TargetNode != null:
		self.look_at(TargetNode.global_position + TargetOffest)
	
	if MovingPathFollow != null:
		MovingPathFollow.progress += _delta * MoveSpeed
