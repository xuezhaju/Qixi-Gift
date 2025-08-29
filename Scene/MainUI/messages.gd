extends ColorRect

# 只需要一个Label节点
@onready var date_label: Label = $DateLabel

# 农历月份和日期名称
var lunar_months = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "冬月", "腊月"]
var lunar_days = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", 
				 "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
				 "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]

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

# 中国传统节日（农历）
var traditional_festivals = [
	{"date": "01-01", "name": "春节", "emoji": "🎉"},
	{"date": "01-15", "name": "元宵节", "emoji": "🏮"},
	{"date": "05-05", "name": "端午节", "emoji": "🎏"},
	{"date": "07-07", "name": "七夕节", "emoji": "💕"},
	{"date": "08-15", "name": "中秋节", "emoji": "🥮"},
	{"date": "09-09", "name": "重阳节", "emoji": "🌼"},
	{"date": "12-30", "name": "除夕", "emoji": "🍲"}
]

# 现代节日（公历）
var modern_festivals = [
	{"date": "01-01", "name": "元旦", "emoji": "🎊"},
	{"date": "03-08", "name": "妇女节", "emoji": "👩"},
	{"date": "05-01", "name": "劳动节", "emoji": "🔧"},
	{"date": "05-04", "name": "青年节", "emoji": "🎓"},
	{"date": "06-01", "name": "儿童节", "emoji": "🧒"},
	{"date": "09-10", "name": "教师节", "emoji": "📚"},
	{"date": "10-01", "name": "国庆节", "emoji": "🇨🇳"}
]

func _ready():
	if date_label:
		update_date_display()
	else:
		push_error("DateLabel节点未找到！")

func update_date_display():
	var now = Time.get_date_dict_from_system()
	var lunar_date = get_simple_lunar_date(now.month, now.day)
	var solar_term = get_solar_term(now.month, now.day)
	var festival = get_festival(now.month, now.day)
	
	var display_text = "📅 今日日期\n\n"
	display_text += "公历: %d年%d月%d日\n" % [now.year, now.month, now.day]
	display_text += "农历: %s%s\n" % [lunar_date.month, lunar_date.day]
	
	if solar_term:
		display_text += "节气: %s%s\n" % [solar_term.emoji, solar_term.name]
	
	if festival:
		display_text += "节日: %s%s\n" % [festival.emoji, festival.name]
	
	display_text += "\n" + get_season_tips(now.month)
	display_text += "\n" + get_daily_suggestion(now.month, now.day)
	
	date_label.text = display_text

# 简化版农历计算（近似值）
func get_simple_lunar_date(month, day):
	# 这是一个简化的农历计算，实际农历需要复杂的算法
	# 这里使用近似值来演示
	var lunar_month = lunar_months[(month - 1) % 12]
	var lunar_day = lunar_days[(day - 1) % 30]
	
	# 特殊处理：正月从春节开始（约2月4日左右）
	if month == 2 and day >= 4:
		lunar_month = lunar_months[0]  # 正月
		lunar_day = lunar_days[(day - 4) % 30]
	
	return {"month": lunar_month, "day": lunar_day}

func get_solar_term(month, day):
	var date_str = "%02d-%02d" % [month, day]
	for term in solar_terms:
		if term.date == date_str:
			return {"name": term.name, "emoji": "🌱"}
	return null

func get_festival(month, day):
	var date_str = "%02d-%02d" % [month, day]
	
	# 先检查现代节日（公历）
	for festival in modern_festivals:
		if festival.date == date_str:
			return festival
	
	# 简化的传统节日检查（实际需要农历计算）
	# 这里使用近似日期
	var approx_festivals = {
		"02-10": {"name": "春节", "emoji": "🎉"},      # 2024年春节
		"02-24": {"name": "元宵节", "emoji": "🏮"},    # 2024年元宵
		"06-10": {"name": "端午节", "emoji": "🎏"},    # 2024年端午
		"08-10": {"name": "七夕节", "emoji": "💕"},    # 近似
		"09-17": {"name": "中秋节", "emoji": "🥮"},    # 2024年中秋
		"10-11": {"name": "重阳节", "emoji": "🌼"},    # 近似
		"02-09": {"name": "除夕", "emoji": "🍲"}       # 2024年除夕
	}
	
	return approx_festivals.get(date_str)

func get_season_tips(month):
	var tips = {
		1: "❄️ 寒冬时节，注意保暖防寒",
		2: "🌬️ 冬春交替，预防感冒",
		3: "🌷 春暖花开，适合户外活动",
		4: "🌦️ 春雨绵绵，记得带伞",
		5: "🌞 初夏时节，注意防晒",
		6: "☀️ 盛夏来临，多喝水防中暑",
		7: "🔥 酷暑难耐，避免高温外出",
		8: "🍂 夏秋之交，天气多变",
		9: "🍁 秋高气爽，适宜出行",
		10: "🌕 金秋时节，收获的季节",
		11: "🍃 深秋凉意，添衣保暖",
		12: "⛄ 寒冬降临，注意防冻"
	}
	return tips.get(month, "享受美好的一天！")

func get_daily_suggestion(month, day):
	var suggestions = [
		"📚 今日宜学习新知识", "💼 适合处理工作事务", "🏃‍♂️ 运动健身好时机",
		"👨‍👩‍👧‍👦 家庭聚会很合适", "🎨 创意灵感爆发日", "🛒 购物消费吉日",
		"🚗 出行顺利平安", "💕 感情交流佳期", "🍎 健康养生好日子",
		"💰 财务决策需谨慎", "🎯 设定目标正当时", "🌱 种植绿化好时机"
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
