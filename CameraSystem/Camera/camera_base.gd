class_name CameraBase
extends Camera3D

var BeContolled: bool = false;

func ControlledBy() -> void:
	BeContolled = true
	self.current = true

func Uncontrolled() -> void:
	BeContolled = false
	self.current = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass
