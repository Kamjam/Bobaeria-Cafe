#https://www.youtube.com/watch?v=PbWtdMQO5jc&list=PLMQtM2GgbPEUsLNqlyHb_qFC8wZr5w7FW&index=2
class_name TimeSystem extends Node

@export var date_time:DateTime
@export var ticks_per_sec:int = 288 #in game time 
var isPaused = false
signal time_system_updated
signal twelve_hr_system_activated
signal day_reset

func _ready() -> void:
	ResetTheDay()
func _process(delta: float) -> void:
	
	if date_time.hours >= 20:
		ResetTheDay()
		
	if Input.is_action_just_pressed("fire"):
		isPaused = false
		ResetTheDay()
	
	if !isPaused:
		date_time.increase_by_sec(delta * ticks_per_sec)
		TimeSys.time_system_updated.emit(date_time)
		TimeSys.twelve_hr_system_activated.emit(date_time)
func ResetTheDay():
	TimeSys.day_reset.emit(date_time)
	date_time.hours = 11
	date_time.mins = 0
	date_time.secs = 0
	
	
