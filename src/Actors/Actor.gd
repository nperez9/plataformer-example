extends KinematicBody2D
class_name Actor

## This indicates the floor-character orientation
const FLOOR_NORMAL = Vector2.UP
export var speed = Vector2(300, 1000)
export var gravity: float = 3000
var _velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	_velocity.y += delta * gravity



