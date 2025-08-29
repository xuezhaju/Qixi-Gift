extends Label

# 起始日期（2020年9月1日）
var start_year = 2020
var start_month = 9
var start_day = 1

func _ready():
	var days_passed = calculate_days_passed()
	days_passed += 1
	self.text = "我们已经相识 %d 天" % days_passed

func calculate_days_passed():
	# 获取当前日期
	var current_datetime = Time.get_datetime_dict_from_system()
	
	# 转换为 Julian Day Number 来计算天数差
	var start_julian = date_to_julian(start_year, start_month, start_day)
	var current_julian = date_to_julian(current_datetime["year"], current_datetime["month"], current_datetime["day"])
	
	return current_julian - start_julian

# 将日期转换为儒略日
func date_to_julian(year, month, day):
	var a = (14 - month) / 12
	var y = year + 4800 - a
	var m = month + 12 * a - 3
	return day + (153 * m + 2) / 5 + 365 * y + y / 4 - y / 100 + y / 400 - 32045
