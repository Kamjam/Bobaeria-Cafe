class_name DateTime extends Resource

@export_category("TIME")
@export var days:int = 0
@export_range(0, 59) var hours:int = 11
@export_range(0, 59) var mins:int = 0
@export_range(0, 59) var secs:int = 0


var delta_time:float = 0

func increase_by_sec(delta_sec:float):
	delta_time += delta_sec
	if delta_time < 1: return
	
	var delta_int_secs:int = delta_time
	delta_time -= delta_int_secs
	
	secs += delta_int_secs
	mins += secs / 60
	hours += mins / 60
	days += hours / 24
	
	secs = secs % 60
	mins = mins % 60
	hours = hours % 60
	
	#print_debug(str(days) + ":" + str(hours) + ":" + str(mins) + ":" + str(secs)) 

#comparing clocks, return secs
func diff_without_days(other_time:DateTime):
	var diff_h = hours - other_time.hours
	var diff_m = mins - other_time.mins + diff_h * 60
	var diff_s = secs - other_time.secs + diff_m * 60

	return diff_s
