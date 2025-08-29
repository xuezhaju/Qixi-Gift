extends Control

@onready var back_color: ColorRect = $BackColor
@onready var dilan: ColorRect = $底栏
@onready var messages: ColorRect = $"../hub/messages"

func _process(delta: float) -> void:
	# 需要将字符串转换为Color类型
	back_color.color = Color(Global.back_color)
	dilan.color = Color(Global.main_color)  # 注意：这里应该是小写 color，不是 Color
	messages.color = Color(Global.main_color)
