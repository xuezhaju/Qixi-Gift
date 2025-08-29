extends Node2D

var heart_color = Color(1, 0, 0)
var heart_points = []
var visible_points = []
var tween: Tween

func _ready():
	# 确保节点可见
	visible = true
	# 设置位置为屏幕中心
	position = get_viewport().get_visible_rect().size / 2
	generate_heart_points()
	start_animation()

func generate_heart_points():
	heart_points.clear()
	var points = 100
	var scale = 10.0  # 进一步减小缩放值，从50降到20
	
	for i in range(points):
		var t = float(i) / points * 2 * PI
		var x = 16 * pow(sin(t), 3)
		var y = 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t)
		heart_points.append(Vector2(x, -y) * scale)

func _draw():
	if visible_points.size() > 1:
		# 使用更细的线条，从5.0降到2.0
		draw_polyline(visible_points, heart_color, 2.0, true)

func start_animation():
	heart_color = Color(randf(), randf(), randf())
	visible_points.clear()
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.set_parallel(false)
	
	# 逐渐出现 - 加快动画速度
	for i in range(heart_points.size()):
		tween.tween_callback(update_points.bind(i + 1))
		tween.tween_interval(0.005)  # 从0.01降到0.005，加快动画
	
	# 等待时间缩短
	tween.tween_interval(1.0)  # 从2.0降到1.0
	
	# 逐渐消失 - 加快动画速度
	for i in range(heart_points.size(), 0, -1):
		tween.tween_callback(update_points.bind(i - 1))
		tween.tween_interval(0.005)  # 从0.01降到0.005，加快动画
	
	# 动画完成后删除自己
	tween.tween_callback(queue_free)

func update_points(count: int):
	visible_points = heart_points.slice(0, count)
	queue_redraw()
