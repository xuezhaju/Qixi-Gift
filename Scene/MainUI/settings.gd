extends Control

# 使用 @onready 注解，在节点进入场景树后获取这些子节点的引用
@onready var back_color_picker: ColorPickerButton = $center/VBoxContainer/BackColor/BackColor
@onready var main_color_picker: ColorPickerButton = $center/VBoxContainer/MainColor/MainColor
@onready var check_button: CheckButton = $center/VBoxContainer/BGM/CheckButton
@onready var volume_slider: HSlider = $center/VBoxContainer/HBoxContainer/HSlider
@onready var volume_value: Label = $center/VBoxContainer/HBoxContainer/Label
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"

# 配置文件路径
const CONFIG_PATH = "user://settings.cfg"

# 添加一个变量来跟踪是否正在拖动滑块
var is_slider_dragging: bool = false

func _ready():
	# 等待所有节点正确初始化
	call_deferred("_initialize_settings")

func _initialize_settings():
	# 在连接信号前验证所有节点都存在
	if back_color_picker:
		back_color_picker.color_changed.connect(_on_back_color_changed)
	else:
		push_error("背景颜色选择器 (back_color_picker) 是空的!")
	
	if main_color_picker:
		main_color_picker.color_changed.connect(_on_main_color_changed)
	else:
		push_error("主颜色选择器 (main_color_picker) 是空的!")
	
	if check_button:
		check_button.toggled.connect(_on_music_toggled)
	else:
		push_error("复选框按钮 (check_button) 是空的!")
	
	if volume_slider:
		# 设置滑块的正确范围 (0-100)
		volume_slider.min_value = 0
		volume_slider.max_value = 100
		volume_slider.step = 1
		volume_slider.value_changed.connect(_on_volume_changed)
		# 连接滑块的拖动开始和结束信号
		volume_slider.gui_input.connect(_on_volume_slider_gui_input)
	else:
		push_error("音量滑块 (volume_slider) 是空的!")
	
	# 加载保存的设置
	load_settings()
	
	# 更新UI显示
	update_ui()
	
	# 初始应用音乐设置
	update_music_state()

func _on_volume_slider_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			# 鼠标按下，开始拖动
			is_slider_dragging = true
		else:
			# 鼠标释放，结束拖动
			is_slider_dragging = false
			# 拖动结束后保存设置
			save_settings()

func _on_back_color_changed(color: Color):
	Global.back_color = color.to_html() # 将颜色转换为HTML字符串格式并保存到全局变量
	save_settings() # 保存设置到文件
	apply_colors()  # 应用颜色更改

func _on_main_color_changed(color: Color):
	Global.main_color = color.to_html()
	save_settings()
	apply_colors()

func _on_music_toggled(toggled: bool):
	Global.music = toggled # 保存音乐开启/关闭状态
	save_settings()
	update_music_state() # 更新音乐播放状态

func _on_volume_changed(value: float):
	# 保存音量值 (0 到 100)
	Global.music_volume = value
	if volume_value:
		volume_value.text = str(int(value)) + "%" # 更新音量百分比显示文本
	
	# 实时更新音量（无论是否拖动）
	update_volume()
	
	# 只有在拖动结束时才保存设置
	if not is_slider_dragging:
		save_settings()

# 更新UI显示
func update_ui():
	# 设置颜色选择器的当前颜色
	if Global.back_color != "" and back_color_picker:
		back_color_picker.color = Color(Global.back_color) # 从字符串转换回Color类型
	if Global.main_color != "" and main_color_picker:
		main_color_picker.color = Color(Global.main_color)
	
	# 设置音乐开关的选中状态
	if check_button:
		check_button.button_pressed = Global.music
	
	# 设置音量滑块的值和显示文本
	if volume_slider:
		volume_slider.value = Global.music_volume
	if volume_value:
		volume_value.text = str(int(Global.music_volume)) + "%"

# 应用颜色设置
func apply_colors():
	# 这里可以根据需要将颜色应用到界面元素
	print("背景颜色: ", Global.back_color)
	print("主颜色: ", Global.main_color)

# 更新音乐状态
func update_music_state():
	if audio_stream_player:
		if Global.music:
			# 开启音乐
			if not audio_stream_player.playing:
				audio_stream_player.play()
			update_volume()
			print("音乐已开启")
		else:
			# 关闭音乐
			audio_stream_player.stop()
			print("音乐已关闭")
	else:
		push_error("AudioStreamPlayer 节点未找到")

# 更新音量
func update_volume():
	if audio_stream_player:
		# 将百分比音量(0-100)转换为线性值(0.0-1.0)
		var linear_volume = clamp(Global.music_volume / 100.0, 0.0, 1.0)
		
		# 设置音量
		audio_stream_player.volume_db = linear_to_db(linear_volume)
		
		print("音量设置为: ", Global.music_volume, "% (线性值: ", linear_volume, ")")
	else:
		push_error("AudioStreamPlayer 节点未找到")

# 保存设置到文件
func save_settings():
	var config = ConfigFile.new() # 创建新的配置文件对象
	
	# 保存颜色设置
	config.set_value("colors", "back_color", Global.back_color)
	config.set_value("colors", "main_color", Global.main_color)
	
	# 保存音频设置
	config.set_value("audio", "music_enabled", Global.music)
	config.set_value("audio", "music_volume", Global.music_volume)
	
	# 保存模式
	config.set_value("general", "mode", Global.mode)
	
	# 保存到文件
	var error = config.save(CONFIG_PATH)
	if error != OK:
		push_error("保存设置失败: " + str(error))
	else:
		print("设置已保存")

# 从文件加载设置
func load_settings():
	var config = ConfigFile.new()
	
	# 如果配置文件不存在，使用默认值
	if not FileAccess.file_exists(CONFIG_PATH):
		set_default_settings()
		return
	
	# 加载配置文件
	var error = config.load(CONFIG_PATH)
	if error != OK:
		push_error("加载设置失败: " + str(error))
		set_default_settings()
		return
	
	# 加载颜色设置 (如果不存在则使用默认值)
	Global.back_color = config.get_value("colors", "back_color", "#f5f5dc")
	Global.main_color = config.get_value("colors", "main_color", "#e8e7b0")
	
	# 加载音频设置 (如果不存在则使用默认值)
	Global.music = config.get_value("audio", "music_enabled", true)
	Global.music_volume = config.get_value("audio", "music_volume", 80)  # 默认80%
	
	# 加载模式 (如果不存在则使用默认值)
	Global.mode = config.get_value("general", "mode", "hub")
	
	print("设置已加载")

# 设置默认值
func set_default_settings():
	Global.back_color = "#f5f5dc"   # 默认背景颜色
	Global.main_color = "#e8e7b0"   # 默认主颜色
	Global.music = true               # 默认开启音乐
	Global.music_volume = 80          # 默认音量 80%
	Global.mode = "hub"               # 默认模式
	print("使用默认设置")

# 重置为默认设置
func reset_to_default():
	set_default_settings()  # 设置默认值
	save_settings()         # 保存默认设置
	update_ui()            # 更新UI显示
	apply_colors()         # 应用颜色
	update_music_state()   # 更新音乐状态
	print("已重置为默认设置")

func _on_reset_button_down() -> void:
	reset_to_default() # 当重置按钮按下时调用重置功能
