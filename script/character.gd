extends CharacterBody2D
@export var health : int
@export var damage : int
@export var speed : float

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var character_sprite: Sprite2D = $CharacterSprite

enum State {IDLE, WALK}

var state = State.IDLE

func flip_sprites():
	if velocity.x > 0:
		# 如果x轴速度大于0，说明朝右走，不需要翻转角色
		character_sprite.flip_h = false
	elif velocity.x < 0:
		character_sprite.flip_h = true

func handle_movement():
	# 这里用状态机来切换主角动画，依据是移动速度，如果为0就认为转移到idle状态
	if velocity.length() == 0:
		state = State.IDLE
	else:
		state = State.WALK

func handle_animation():
	if state == State.IDLE:
		animation_player.play("idle")
	elif state == State.WALK:
		animation_player.play("walk")

func handle_input():
	#if Input.is_action_pressed("move_right"):
		## 向右移动角色 1像素
		#position += Vector2.RIGHT * delta * speed
	#if Input.is_action_pressed("move_left"):
		## 向右移动角色 1像素
		#position += Vector2.LEFT * delta * speed
	#if Input.is_action_pressed("move_up"):
		## 向右移动角色 1像素
		#position += Vector2.UP * delta * speed
	#if Input.is_action_pressed("move_down"):
		## 向右移动角色 1像素
		#position += Vector2.DOWN * delta * speed
	
	#上面的控制移动的方式存在一个问题，比如同时按上和右方向，那么此时在xy轴同时挪动一个像素
	#得到的结果一定是斜右上方向超过一个像素，是直角三角的斜边长
	#所以下面要使用向量归一化操作，就是让它始终是一个圆的半径长度，不以方向为转移
	#godot就提供了内置的方法get_vector，直接使用它即可
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed

func _process(delta: float) -> void:
	handle_input()
	handle_movement()
	handle_animation()
	flip_sprites()
	move_and_slide()
	
	
	
	
	
