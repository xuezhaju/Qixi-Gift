extends Node

# 爱心场景预设
var heart_scene = preload("res://Scene/heart.tscn") # 请替换为你的爱心场景路径

# 摇晃检测参数
var shake_threshold = 2.0  # 降低阈值，提高灵敏度
var shake_cooldown = 1.0    # 两次摇晃之间的冷却时间
var last_shake_time = 0.0   # 上次摇晃的时间

# 加速度计数据
var acceleration = Vector3()
var previous_acceleration = Vector3()

func _ready():
	# 确保处理输入
	set_process(true)

func _process(delta):
	# 获取当前时间
	var current_time = Time.get_ticks_msec() / 1000.0
	
	# 检查是否在冷却时间内
	if current_time - last_shake_time < shake_cooldown:
		return
	
	# 获取加速度计数据
	previous_acceleration = acceleration
	acceleration = Input.get_accelerometer()
	
	# 计算加速度变化率
	var delta_acceleration = acceleration - previous_acceleration
	var shake_intensity = delta_acceleration.length()
	
	# 如果变化率超过阈值，触发摇晃事件
	if shake_intensity > shake_threshold or Input.is_action_just_pressed("ui_accept"):
		on_shake_detected()
		last_shake_time = current_time

func on_shake_detected():
	print("摇晃检测到!")
	
	# 创建爱心实例
	var heart = heart_scene.instantiate()
	get_tree().current_scene.add_child(heart)
	
	# 设置爱心的随机位置（在屏幕范围内）
	var screen_size = get_viewport().get_visible_rect().size
	heart.position = Vector2(
		randf_range(50, screen_size.x - 50),
		randf_range(50, screen_size.y - 50)
	)
	
	# 可选：添加一些随机缩放和旋转
	heart.scale = Vector2(1, 1) * randf_range(0.5, 1.2)
	heart.rotation = randf_range(-0.2, 0.2)
	
	# 可选：播放声音效果
	# $ShakeSound.play()
	
	print("爱心出现！位置: ", heart.position)
