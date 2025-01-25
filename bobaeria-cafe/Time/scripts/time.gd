#https://www.youtube.com/watch?v=PbWtdMQO5jc&list=PLMQtM2GgbPEUsLNqlyHb_qFC8wZr5w7FW&index=2
class_name TimeSystem extends Node

@export var date_time:DateTime
@export var ticks_per_sec:int = 288 #in game time 

var twelve_hr:int

signal time_system_updated
signal twelve_hr_system_activated

func _process(delta: float) -> void:
	date_time.increase_by_sec(delta * ticks_per_sec)
	TimeSys.time_system_updated.emit(date_time)
	TimeSys.twelve_hr_system_activated.emit(date_time)
