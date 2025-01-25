extends Control

@onready var day_label:Label = $VBoxContainer/DayCounter/day
@onready var hour_label:Label = $VBoxContainer/Clock/hours
@onready var min_label:Label = $VBoxContainer/Clock/mins

#@export var day_label:Label
#@export var hour_label:Label
#@export var min_label:Label

func _ready() -> void:
	TimeSys.time_system_updated.connect(_on_time_system_updated)

func _on_time_system_updated(date_time:DateTime):
	update_label(day_label, date_time.days, false)
	update_label(hour_label, date_time.hours)
	update_label(min_label, date_time.mins)
	
	#day_label.text = str(date_time.days)
	#hour_label.text = str(date_time.hours)
	#min_label.text = str(date_time.mins)

func add_leading_zero(label:Label, value:int):
	if value < 10: label.text += '0'

func update_label(label:Label, value:int, add_zero:bool = true):
	label.text = ""
	
	if add_zero:
		add_leading_zero(label, value)
	
	label.text += str(value)
