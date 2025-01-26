#https://www.youtube.com/watch?v=PbWtdMQO5jc&list=PLMQtM2GgbPEUsLNqlyHb_qFC8wZr5w7FW&index=2
class_name TimeSystem extends Node

@export var date_time:DateTime
@export var ticks_per_sec:int = 288 #in game time 
var isPaused = false
signal time_system_updated
signal twelve_hr_system_activated
signal day_reset

@export var theSun : Node3D


func _process(delta: float) -> void:
	
	#20 is 8pm
	if date_time.hours >= 12:
		isPaused = true

		
	if Input.is_action_just_pressed("ui_home"):
		isPaused = true
		ResetTheDay()
		
	if !isPaused:
		date_time.increase_by_sec(delta * ticks_per_sec)
		TimeSys.time_system_updated.emit(date_time)
		TimeSys.twelve_hr_system_activated.emit(date_time)
func ResetTheDay():
	if theSun:
		theSun.ResetDay()
	date_time.hours = 11
	date_time.mins = 0
	date_time.secs = 0
	
func Unpause():
	isPaused = false
	
