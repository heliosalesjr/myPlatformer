extends Area2D

var _direction: Vector2 = Vector2.RIGHT # (1,0)
var _life_span: float = 20.0
var _life_time: float = 0.0

func _ready():
	pass
	
func _process(delta):
	check_expired(delta)
	position += _direction * delta * 20
	
func setup(dir: Vector2, _life_span, speed):
	_direction = dir.normalized() * speed
	_life_span = _life_span

func check_expired(delta: float) -> void:
	_life_time += delta
	if _life_time > _life_span:
		queue_free()

func _on_area_entered(area):
	queue_free()
