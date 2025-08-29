extends Sprite2D

# 图片路径数组
var image_paths = [
	"res://Asset/001.jpg",
	"res://Asset/002.jpg", 
	"res://Asset/003.jpeg",
	"res://Asset/004.jpeg",
	"res://Asset/005.jpg", 
	"res://Asset/006.jpg",
	"res://Asset/007.jpg"
]

func _ready():
	# 设置初始大小
	self.scale = Vector2(0.5, 0.5)  # 根据实际图片尺寸调整缩放比例
	# 加载随机初始图片
	load_random_image()

func _input(event):
	# 检测鼠标点击事件
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# 检查是否点击了这个Sprite
		if is_clicked(event.position):
			load_random_image()

# 检查点击位置是否在这个Sprite范围内
func is_clicked(click_position: Vector2) -> bool:
	var sprite_rect = Rect2(
		global_position - (texture.get_size() * scale) / 2,
		texture.get_size() * scale
	)
	return sprite_rect.has_point(click_position)

# 加载随机图片
func load_random_image():
	if image_paths.size() == 0:
		return
	
	var random_index = randi() % image_paths.size()
	var texture_path = image_paths[random_index]
	
	# 加载图片纹理
	var new_texture = load(texture_path)
	if new_texture:
		self.texture = new_texture
		resize_to_170x170()

# 调整图片大小为170x170像素
func resize_to_170x170():
	if texture:
		var original_size = texture.get_size()
		var target_size = Vector2(170, 170)
		
		# 计算缩放比例，保持宽高比
		var scale_x = target_size.x / original_size.x
		var scale_y = target_size.y / original_size.y
		var min_scale = min(scale_x, scale_y)
		
		self.scale = Vector2(min_scale, min_scale)
