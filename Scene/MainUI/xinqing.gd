extends Control

@onready var rich_text_label: RichTextLabel = $VBoxContainer/ColorRect/RichTextLabel

# 定义各种情绪的安慰鼓励文本数组
var happy_texts = [
	"真为你感到高兴！继续保持这份好心情！",
	"快乐是会传染的，你的笑容也能温暖他人~",
	"珍惜这份美好，让快乐的时光更长一些！",
	"愿你的每一天都像今天一样充满阳光！",
	"快乐是最好的良药，继续保持哦！",
	"看到你开心，我也觉得心情很好呢！",
	"把这份快乐分享给身边的人吧！",
	"保持积极心态，好事会接连发生的！"
]

var justsoso_texts = [
	"平淡的日子也是生活的一部分，学会享受宁静~",
	"有时候，平凡就是最大的幸福呢",
	"给自己泡杯茶，享受这片刻的宁静吧",
	"平静的心境很难得，好好珍惜这一刻",
	"在平凡中寻找小确幸，生活会更有滋味",
	"休息一下也很好，给自己充充电",
	"这样的时刻正好可以反思和规划呢",
	"平淡中藏着生活的智慧，慢慢体会"
]

var sad_texts = [
	"难过的时候不要一个人扛着，我在这里陪着你",
	"眼泪洗刷过的心灵会更加清澈明亮",
	"这只是一时的阴霾，阳光很快就会回来的",
	"允许自己悲伤，但不要忘记你有多珍贵",
	"给我一个拥抱吧，一切都会好起来的",
	"你并不孤单，很多人都在关心着你",
	"悲伤也是成长的一部分，你会变得更坚强",
	"深呼吸，给自己一点时间和空间"
]

var angry_texts = [
	"先深呼吸，冷静下来再处理问题会更好",
	"生气伤身，为了不值得的事不值得",
	"我理解你的感受，但不要让怒气控制你",
	"换个角度想想，也许会有不同的看法",
	"出去走走散散心，让情绪平复一下",
	"愤怒是暂时的，不要让它影响你的判断",
	"你可以选择不被这些事情影响心情",
	"把注意力转移到喜欢的事情上吧"
]

var afraid_texts = [
	"勇敢不是不害怕，而是害怕依然前行",
	"我在这里支持你，你可以克服恐惧的",
	"一步一步来，不用急着面对所有事情",
	"恐惧只是想象中的怪物，实际并不可怕",
	"你已经比想象中要勇敢得多",
	"每个人都会害怕，这很正常",
	"相信自己，你有能力应对挑战",
	"恐惧会过去，但勇气会留下来"
]

func _on_happy_button_down() -> void:
	# 随机选择一句快乐鼓励语
	var random_text = happy_texts[randi() % happy_texts.size()]
	rich_text_label.text = "😊 快乐时刻\n\n" + random_text

func _on_justsoso_button_down() -> void:
	# 随机选择一句平静安慰语
	var random_text = justsoso_texts[randi() % justsoso_texts.size()]
	rich_text_label.text = "😐 平静时刻\n\n" + random_text

func _on_sad_button_down() -> void:
	# 随机选择一句悲伤安慰语
	var random_text = sad_texts[randi() % sad_texts.size()]
	rich_text_label.text = "😢 难过时刻\n\n" + random_text

func _on_angry_button_down() -> void:
	# 随机选择一句愤怒安抚语
	var random_text = angry_texts[randi() % angry_texts.size()]
	rich_text_label.text = "😠 生气时刻\n\n" + random_text

func _on_afraid_button_down() -> void:
	# 随机选择一句恐惧鼓励语
	var random_text = afraid_texts[randi() % afraid_texts.size()]
	rich_text_label.text = "😨 害怕时刻\n\n" + random_text
