extends Node2D
@onready var camera: Camera2D = $Camera
@onready var player: CharacterBody2D = $Player

func _process(delta: float) -> void:
	# 相机和player都是world下的子节点，所以相机的移动逻辑写在world里面，而不要写player或相机里面
	# 保持相机和player的解耦
	if player.position.x > camera.position.x:
		camera.position.x = player.position.x
