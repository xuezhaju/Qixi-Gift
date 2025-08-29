extends ColorRect

# 只需要一个Label节点
@onready var date_label: RichTextLabel = $DateLabel

# 二十四节气
var solar_terms = [
	{"date": "02-04", "name": "立春"}, {"date": "02-19", "name": "雨水"}, {"date": "03-05", "name": "惊蛰"},
	{"date": "03-20", "name": "春分"}, {"date": "04-04", "name": "清明"}, {"date": "04-20", "name": "谷雨"},
	{"date": "05-05", "name": "立夏"}, {"date": "05-21", "name": "小满"}, {"date": "06-06", "name": "芒种"},
	{"date": "06-21", "name": "夏至"}, {"date": "07-07", "name": "小暑"}, {"date": "07-23", "name": "大暑"},
	{"date": "08-08", "name": "立秋"}, {"date": "08-23", "name": "处暑"}, {"date": "09-08", "name": "白露"},
	{"date": "09-23", "name": "秋分"}, {"date": "10-08", "name": "寒露"}, {"date": "10-23", "name": "霜降"},
	{"date": "11-07", "name": "立冬"}, {"date": "11-22", "name": "小雪"}, {"date": "12-07", "name": "大雪"},
	{"date": "12-22", "name": "冬至"}, {"date": "01-05", "name": "小寒"}, {"date": "01-20", "name": "大寒"}
]

# 现代节日（公历）
var modern_festivals = [
	{"date": "01-01", "name": "元旦", "emoticon": "(≧∇≦)ﾉ"},
	{"date": "02-14", "name": "情人节", "emoticon": "(qωq)"},
	{"date": "03-08", "name": "妇女节", "emoticon": "(づ￣ ³￣)づ"},
	{"date": "03-12", "name": "植树节", "emoticon": "(Q｡•̀ᴗ-)✧"},
	{"date": "04-01", "name": "愚人节", "emoticon": "(¬‿¬)"},
	{"date": "05-01", "name": "劳动节", "emoticon": "(•̀o•́)ง"},
	{"date": "05-04", "name": "青年节", "emoticon": "(•̀ᴗ•́)و"},
	{"date": "06-01", "name": "儿童节", "emoticon": "ヾ(◍°∇°◍)ﾉﾞ"},
	{"date": "09-10", "name": "教师节", "emoticon": "(´• ω •`)ﾉ"},
	{"date": "10-01", "name": "国庆节", "emoticon": "ヽ(★ω★)ノ"},
	{"date": "12-24", "name": "平安夜", "emoticon": "(☆▽☆)"},
	{"date": "12-25", "name": "圣诞节", "emoticon": "(*^▽^*)"}
]

func _ready():
	if date_label:
		# 设置RichTextLabel居中显示
		date_label.bbcode_enabled = true
		date_label.scroll_active = false
		update_date_display()
	else:
		push_error("DateLabel节点未找到！")

func update_date_display():
	var now = Time.get_date_dict_from_system()
	var solar_term = get_solar_term(now.month, now.day)
	var festival = get_festival(now.month, now.day)
	
	# 使用BBCode实现居中显示和格式化
	var display_text = "[center][b] 今日日期[/b][/center]\n\n"
	display_text += "[center]公历: %d年%d月%d日[/center]\n" % [now.year, now.month, now.day]
	
	if solar_term:
		display_text += "[center]节气: %s %s[/center]\n" % [solar_term.emoticon, solar_term.name]
	
	if festival:
		display_text += "[center]节日: %s %s[/center]\n" % [festival.emoticon, festival.name]
	
	display_text += "\n[center]" + get_season_tips(now.month) + "[/center]"
	display_text += "\n[center]" + get_daily_suggestion(now.month, now.day) + "[/center]"
	
	date_label.text = display_text

func get_solar_term(month, day):
	var date_str = "%02d-%02d" % [month, day]
	for term in solar_terms:
		if term.date == date_str:
			return {"name": term.name, "emoticon": "(🌱･ω･)?"}
	return null

func get_festival(month, day):
	var date_str = "%02d-%02d" % [month, day]
	
	# 检查现代节日（公历）
	for festival in modern_festivals:
		if festival.date == date_str:
			return festival
	
	return null

func get_season_tips(month):
	var tips = {
		1: " 寒冬时节，注意保暖防寒 (｡•́︿•̀｡)",
		2: " 冬春交替，预防感冒 (。-ω-)zzz",
		3: " 春暖花开，适合户外活动 (◕‿◕✿)",
		4: " 春雨绵绵，记得带伞 (´･ω･`)?",
		5: " 初夏时节，注意防晒 (￣ω￣;)",
		6: " 盛夏来临，多喝水防中暑 (；一_一)",
		7: " 酷暑难耐，避免高温外出 (´-﹏-`；)",
		8: " 夏秋之交，天气多变 (・_・;)",
		9: " 秋高气爽，适宜出行 (＾▽＾)",
		10: " 金秋时节，收获的季节 (✿◠‿◠)",
		11: " 深秋凉意，添衣保暖 (｡•̀ᴗ-)✧",
		12: " 寒冬降临，注意防冻 (っ˘̩╭╮˘̩)っ"
	}
	return tips.get(month, "享受美好的一天！ (＾ω＾)")

func get_daily_suggestion(month, day):
	var suggestions = [
		" 今日宜学习新知识 (´∀`)",
		" 适合处理工作事务 (•̀o•́)ง",
		" 运动健身好时机 (＾• ω •＾)",
		" 家庭聚会很合适 (＾▽＾)",
		" 创意灵感爆发日 (☆▽☆)",
		" 购物消费吉日 (￣▽￣*)",
		" 出行顺利平安 (´▽`ʃ♡ƪ)",
		" 感情交流佳期 (qωq)",
		" 健康养生好日子 (◠‿◠✿)",
		" 财务决策需谨慎 (・人・)",
		" 设定目标正当时 (•̀ᴗ•́)و",
		" 种植绿化好时机 (✿◡‿◡)"
	]
	
	# 根据日期生成相对固定的建议
	var index = (month * 31 + day) % suggestions.size()
	return suggestions[index]

# 自动更新时间显示
func _process(delta):
	if int(Time.get_ticks_msec() / 1000) % 10 == 0:  # 每10秒更新一次
		update_date_display()

# 键盘控制
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_R:
			update_date_display()
