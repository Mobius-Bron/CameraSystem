extends PathFollow3D

@export var MoveSpeed: float = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.progress = self.progress + _delta * MoveSpeed
