extends DirectionalLight3D

@export_category("COLOR SETTINGS")
@export_color_no_alpha var day_color:Color
@export var evening_color:Color

@export_category("TIME SETTINGS")
@export var day_start:DateTime
@export var evening_start:DateTime
@export var transition_time:int = 30 #in mins
@export var time_system:TimeSystem

enum DayState {DAY, EVENING}
var cur_state: DayState = DayState.DAY
var in_transition:bool = false

@onready var time_map: Dictionary = {
	DayState.DAY: day_start,
	DayState.EVENING: evening_start,
}

@onready var transition_map: Dictionary = {
	DayState.DAY: DayState.EVENING,
	DayState.EVENING: DayState.DAY,
}

@onready var color_map: Dictionary = {
	DayState.DAY: day_color,
	DayState.EVENING: evening_color,
}

func _ready() -> void:
	TimeSys.time_system_updated.connect(_on_time_system_updated)
	$".".rotation_degrees = Vector3(-45,90,0)
	#makes sure that everything is symched with the main time system
	var diff_day_start = time_system.date_time.diff_without_days(day_start)
	var diff_evening_start = time_system.date_time.diff_without_days(evening_start)
	if diff_day_start < 0 or diff_evening_start > 0: cur_state = DayState.EVENING


func _on_time_system_updated(game_time:DateTime):
	var next_state = transition_map[cur_state]
	var change_time = time_map[next_state]
	var time_diff = change_time.diff_without_days(game_time)
	
	if in_transition:
		update_transition(time_diff, next_state)
	elif time_diff > 0 and time_diff < (transition_time * 60):
		in_transition = true
		update_transition(time_diff, next_state)
	else:
		self.light_color = color_map[cur_state]

func update_transition(time_diff:int, next_state:DayState):
	var ratio = 1 - (time_diff as float / (transition_time * 60))
	if ratio > 1:
		cur_state = next_state
		in_transition = false
	else:
		self.light_color  = color_map[cur_state].lerp(color_map[next_state], ratio)

func _process(delta: float) -> void:
	$".".rotation_degrees.x -= 0.002
	#default 1.5 light energy
	if $".".light_energy > 0.1:
		$".".light_energy -= 0.0001
