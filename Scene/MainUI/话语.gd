extends Label

# 365条每日话语数组
var daily_messages = [
	"早安，我的宝贝。今天也是爱你的一天。",
	"你是我每一天早起的动力。",
	"想起你的笑容，就是我一天中最美好的时刻。",
	"今天天气很好，就像我的心情因为想你一样晴朗。",
	"早餐吃了吗？要记得照顾好自己。",
	"工作再忙，也要记得休息一下，想想我。",
	"你是我生命中最美丽的意外。",
	"今晚想吃什么？我给你做。",
	"每天爱你更多一点。",
	"你是我最珍贵的宝藏。",
	"今天有想我吗？我每时每刻都在想你。",
	"你的存在让我的世界变得完整。",
	"无论发生什么，我都在你身边。",
	"你笑起来的样子最好看。",
	"好想现在就抱抱你。",
	"你是我坚定不移的选择。",
	"今天也要一起加油哦！",
	"和你在一起的每一天都是情人节。",
	"你是我最温暖的港湾。",
	"爱你是我做过最简单也是最正确的事。",
	"今天天气转凉，记得多穿点衣服。",
	"你是我心跳的理由。",
	"好想时间就停留在我们相拥的时刻。",
	"你是我所有的少女情怀和心之所向。",
	"今天工作累不累？晚上给你按摩。",
	"遇见你，花光了我所有的运气。",
	"你是我漫长人生中所有的期待。",
	"想和你一起浪费时光，直到永远。",
	"你的名字是我听过最短的情诗。",
	"今天也是为你心动的一天。",
	
	# 4月专属话语（31条）- 索引30到60
	"四月的风里都是想你的味道。",
	"樱花飘落的季节，想和你一起散步。",
	"你是人间的四月天，笑响点亮了四面风。",
	"春天适合恋爱，更适合我们。",
	"想把你和春天一起拥入怀中。",
	"春风十里，不如你。",
	"花开的时候，我就想起了你。",
	"你比春天的一切都要美好。",
	"我们的爱情就像春天，永远充满生机。",
	"想和你一起去春游，只有我们两个人。",
	"你是我永不凋零的春天。",
	"四月的阳光和你一样温暖。",
	"好想闻闻你头发上的香味。",
	"你是我唯一想要并肩同行的人。",
	"今天特别想你，比昨天多一点，比明天少一点。",
	"你的眼睛里有星辰大海。",
	"想和你一起看遍四季轮回。",
	"你是我最想留住的幸运。",
	"爱上你，是我此生最美好的决定。",
	"想把你藏进口袋，走到哪里都带着。",
	"你是我的今天和所有的明天。",
	"一想到你，我的心里就开满了花。",
	"你的手是我最想紧握的未来。",
	"爱你不是一时兴起，而是深思熟虑。",
	"你是我枯燥生活里最甜的那颗糖。",
	"想和你一起虚度光阴，比如低头看鱼。",
	"你是我温暖的手套，冰冷的啤酒。",
	"有你在身边，风都超级甜。",
	"今天比昨天更加喜欢你。",
	"你是我最完美的默契。",
	"四月的最后一天，爱你的心依旧满满。",
	
	# 其他月份的话语 - 索引61开始
	"五月到了，想和你一起去海边。",
	"夏天的风，我永远记得，清清楚楚说你爱我。",
	"你是夏日限定的美好，也是来日方长的期待。",
	"想和你一起吃西瓜，最中间的那一口给你。",
	"你是我三十九度的风，风一样的梦。",
	
	# 纪念日和特殊日期提示
	"还记得我们第一次见面的那天吗？你穿的那件衣服真好看。",
	"今天是我们第一次牵手的纪念日，当时我的心跳得好快。",
	"还记得我们第一次约会去的那个地方吗？",
	"你生日那天，你许的愿望里有我吗？",
	
	# 鼓励和支持的话语
	"今天遇到什么不开心的事了吗？我的怀抱永远为你敞开。",
	"不要怕，勇敢去尝试，我会一直在你身后支持你。",
	"你已经做得很棒了，不要给自己太大压力。",
	"累了吗？我的肩膀借你靠。",
	"你是最棒的，我相信你一定能做到。",
	"失败也没关系，我陪你一起重新开始。",
	"你的努力我都看在眼里，心疼又骄傲。",
	"慢慢来，我会一直等你。",
	"不要委屈自己，有什么话都可以和我说。",
	"你值得世界上所有的美好。",
	
	# 生活琐事的关心
	"明天要下雨，记得带伞。",
	"天气干燥，要多喝水哦。",
	"晚上不要熬夜太晚，对身体不好。",
	"胃不好记得按时吃饭，别饿着了。",
	"下班路上注意安全，到了告诉我一声。",
	
	# 浪漫情话
	"我想和你一起生活，在某个小镇，共享无尽的黄昏。",
	"你是我的文艺复兴，带我走出黑暗给我新生。",
	"你是我漫长岁月里所有的温柔与浪漫。",
	"我喜欢你，像风走了八千里，不问归期。",
	"你是我贫瘠土地上最后的玫瑰。",
	"山河远阔，人间烟火，无一是你，无一不是你。",
	"醒来觉得，甚是爱你。",
	"我不喜欢这个世界，我只喜欢你。",
	"你是我的可遇不可求，可遇不可留，可遇不可有。",
	"你是我温暖的手套，冰冷的啤酒。",
	
	# 幽默可爱型
	"今天有没有乖乖想我？",
	"报告！今天也想你了！",
	"你最近是不是又胖了？为什么你在我心里的分量越来越重了？",
	"你是碳酸饮料吗？为什么我一看到你就开心得冒泡？",
	"我怀疑你的本质是一本书，不然为什么我越看越想睡。",
	
	# 承诺与未来
	"想和你有一个很长很长的未来。",
	"等我们老了，就回乡下种花养狗。",
	"我会努力成为更好的自己，然后去见你。",
	"你的过去我来不及参与，你的未来我奉陪到底。",
	"我想每天醒来第一眼看到的就是你。",
	
	# 夏季话语
	"六月的阳光像你一样炽热耀眼。",
	"夏天来了，想和你一起喝冰镇汽水。",
	"你是夏日海边最清凉的海风。",
	"想和你一起看夏夜的星空。",
	"你的笑容比夏日的阳光还要灿烂。",
	
	# 秋季话语
	"秋天的第一杯奶茶，想和你一起喝。",
	"枫叶红了，就像我爱你的心一样炽热。",
	"想和你一起踩在落叶上，听沙沙的声音。",
	"你是秋日里最温暖的那一抹阳光。",
	
	# 冬季话语
	"冬天到了，想和你一起取暖。",
	"你的手冷吗？我可以帮你暖手。",
	"想和你一起看初雪，听说一起看初雪的人会永远在一起。",
	"你是冬日里最温暖的那杯热可可。",
	
	# 继续添加更多话语直到足够数量...
	"每一天都比前一天更爱你。",
	"我们的故事，永远都不会结束。",
	"新的一年，还想继续爱你。",
	"感谢有你的每一天。",
	"你是我永不后悔的选择。",
	"想和你一起慢慢变老。",
	"你的每一个小习惯我都觉得可爱。",
	"在我眼里，你永远都是最好的。",
	"爱你是我最幸福的事。",
	"今天也想听听你的声音。"
]

func _ready():
	# 设置标签属性
	self.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	self.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	self.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	self.clip_text = false
	
	# 获取当前日期和消息
	var current_date = Time.get_datetime_dict_from_system()
	var current_month = current_date["month"]
	var current_day = current_date["day"]
	var message_to_show = get_daily_message(current_month, current_day)
	
	# 更新Label文本
	self.text = message_to_show
	
	# 等待一帧后调整字体大小
	call_deferred("adjust_font_size_advanced")

func adjust_font_size_advanced():
	var max_font_size = 48
	var min_font_size = 12
	var current_size = max_font_size
	
	# 二分查找合适的字体大小
	while current_size >= min_font_size:
		self.add_theme_font_size_override("font_size", current_size)
		
		# 强制重绘并等待一帧
		await get_tree().process_frame
		
		# 检查文本是否超出边界
		var text_size = self.get_size()
		var label_size = self.size
		
		if text_size.y <= label_size.y and text_size.x <= label_size.x:
			break  # 找到了合适的字体大小
		
		current_size -= 2  # 每次减少2px
	
	# 确保字体大小在最小范围内
	self.add_theme_font_size_override("font_size", max(min_font_size, current_size))
	print("最终字体大小: ", max(min_font_size, current_size), "px")
	
func get_daily_message(month: int, day: int) -> String:
	# 如果是4月，显示对应的4月专属话语
	if month == 4:
		# 确保日期在1-31范围内
		var april_index = clamp(day - 1 + 30, 30, 60)
		return daily_messages[april_index]
	else:
		# 其他月份，从非4月话语中随机选择
		# 非4月话语的索引范围：0-29 和 61-最后
		var random = RandomNumberGenerator.new()
		random.randomize()
		
		# 创建非4月话语的索引数组
		var non_april_indices = []
		for i in range(0, 30):  # 前30条
			non_april_indices.append(i)
		for i in range(61, daily_messages.size()):  # 61条之后的所有话语
			non_april_indices.append(i)
		
		# 随机选择一个索引
		var random_index = random.randi_range(0, non_april_indices.size() - 1)
		return daily_messages[non_april_indices[random_index]]

# 可选：每天自动更新一次
func _process(delta):
	# 每60帧检查一次（约每秒一次）
	if Engine.get_frames_drawn() % 600 == 0:
		var current_date = Time.get_datetime_dict_from_system()
		var current_month = current_date["month"]
		var current_day = current_date["day"]
		
		var message_to_show = get_daily_message(current_month, current_day)
		self.text = message_to_show

func _notification(what):
	if what == NOTIFICATION_RESIZED:
		call_deferred("adjust_font_size_advanced")
