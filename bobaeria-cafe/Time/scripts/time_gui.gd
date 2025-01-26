extends Control

@export_category("GUI LABELS")
#@export var day_label:Label
@export var hour_label:Label
@export var min_label:Label
@export var meridiem_label:Label
@export var is_twelve_hr_clock:bool

@export var day_img:Node
var SUN = preload("res://Icons/icons8-sun-48.png")
var MOON = preload("res://Icons/icons8-moon-48.png")

enum MState {AM, PM}
var cur_state: MState = MState.AM

func _ready() -> void:
	day_img.texture = SUN
	TimeSys.time_system_updated.connect(_on_time_system_updated)
	TimeSys.twelve_hr_system_activated.connect(_on_twelve_hr_system_activated)

func _on_time_system_updated(date_time:DateTime):
	#update_label(day_label, date_time.days, false)
	update_label(hour_label, date_time.hours)
	update_label(min_label, date_time.mins)
	calc_meridiem(date_time.hours)
	
	if date_time.hours >= 17:
		day_img.texture = MOON


func _on_twelve_hr_system_activated(date_time:DateTime):
	if is_twelve_hr_clock and date_time.hours >= 13: 
		update_label(hour_label, date_time.twelve_hr)
	if is_twelve_hr_clock and date_time.hours == 24: 
		is_twelve_hr_clock = false

func calc_meridiem(hours:int):
	if hours >= 12 and cur_state == MState.AM:
		cur_state = MState.PM 
		meridiem_label.text = "PM"
	if hours < 12 and cur_state == MState.PM:
		cur_state = MState.AM
		meridiem_label.text = "AM"
func add_leading_zero(label:Label, value:int):
	if value < 10: label.text += '0'

func update_label(label:Label, value:int, add_zero:bool = true):
	label.text = ""
	
	if add_zero:
		add_leading_zero(label, value)
	
	label.text += str(value)
