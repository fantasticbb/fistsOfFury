extends StaticBody2D

@onready var damage_receiver: DamageReceiver = $DamageReceiver
@onready var sprite: Sprite2D = $Sprite2D

@export var knockback_intensity : float

# 初始化重力参数，用于控制浮空
const GRAVITY := 600.0

enum State {IDLE, DESTROYED}

var state := State.IDLE
var velocity := Vector2.ZERO
var height = 0.0
var height_speed = 0.0

func _ready() -> void:
	damage_receiver.damage_received.connect(on_receive_damage.bind())

func _process(delta: float) -> void:
	position += velocity * delta
	sprite.position = Vector2.UP * height
	handle_air_time(delta)

func on_receive_damage(damage: int, direction: Vector2) -> void:
	if state == State.IDLE:
		sprite.frame = 1
		height_speed = knockback_intensity * 2
		state = State.DESTROYED
		velocity = direction * knockback_intensity

# 涉及移动的，都加上delta参数
func handle_air_time(delta: float) -> void:
	if state == State.DESTROYED:
		# 下面这个是直接让被摧毁的物体逐渐透明
		modulate.a -= delta
		# 下面这个是控制被摧毁物体的浮空高度
		height += height_speed * delta
		if height < 0:
			height = 0
			queue_free()
		else:
			height_speed -= GRAVITY * delta
