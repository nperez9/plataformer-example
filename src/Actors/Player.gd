extends Actor

export var stomp_impulse: float = 1000.0


func _on_EnemyDetector_area_entered(area) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _physics_process(delta: float) -> void:
	#logica para interrupir el salto(tipo super mario)
	var interrup_jump: bool = Input.is_action_just_released("jump") and _velocity.y < 0.0
	## Esto resuelve una cantidad de bugs que se me cae el DIU, tambien toma cosas como el movimiento del stick
	var direction: Vector2 = get_direction()
	## Variables extendidas de actor
	_velocity = calculate_move_velocity(_velocity, direction, speed, delta, interrup_jump)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 1.0
	)	
# end get_direction
	
func calculate_move_velocity(
	linear_velocity: Vector2, 
	direction: Vector2, 
	speed: Vector2,
	delta: float,
	interrup_jump: bool
) -> Vector2:
	var out: Vector2 = linear_velocity
	out.x = direction.x * speed.x
	out.y += gravity * delta
	
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if interrup_jump:
		out.y = 0
	
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: Vector2 = linear_velocity
	out.y = -impulse
	return out
	

func _on_EnemyDetector_body_entered(body):
	queue_free()
