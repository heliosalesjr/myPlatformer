extends CharacterBody2D

class_name Player

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

const GRAVITY: float = 1000.0
const RUN_SPEED: float = 320.0
const MAX_FALL: float = 400.0
const HURT_TIME: float = 0.3
const JUMP_VELOCITY: float = -400.0

#enumerated constant
enum PLAYER_STATE {IDLE, RUN, JUMP, FALL, HURT}
var _state: PLAYER_STATE = PLAYER_STATE.IDLE


func _ready():
	pass

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += GRAVITY * delta
	get_input()
	move_and_slide()
	calculate_state()

func get_input() -> void:
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -RUN_SPEED
		sprite_2d.flip_h = true
	if Input.is_action_pressed("right"):
		velocity.x = RUN_SPEED
		sprite_2d.flip_h = false
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)
		
func calculate_state():
	if _state == PLAYER_STATE.HURT:
		return
		
	if is_on_floor():
		if velocity.x == 0:
			set_state(PLAYER_STATE.IDLE)
		else:
			set_state(PLAYER_STATE.RUN)
	else:
		if velocity.y  > 0:
			set_state(PLAYER_STATE.FALL)
		else:
			set_state(PLAYER_STATE.JUMP)
			
func set_state(new_state: PLAYER_STATE):
	if new_state == _state:
		return
	_state = new_state
	
	match _state:
		PLAYER_STATE.IDLE:
			animation_player.play("idle")
		PLAYER_STATE.RUN:
			animation_player.play("run")
		PLAYER_STATE.JUMP:
			animation_player.play("jump")
		PLAYER_STATE.FALL:
			animation_player.play("fall")
		PLAYER_STATE.HURT:
			animation_player.play("hurt")
