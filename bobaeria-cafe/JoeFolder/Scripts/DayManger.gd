extends  Node3D
@onready var time_system = $"../TimeSystem"
@onready var dayOverMenu = $"../Day Over Screen"
@onready var drinkMenu =  $"../NavigationRegion3D/Table9"
@onready var theSun = $"../THE SUN"
@export var ref : Node3D


func _ready() -> void:
	dayOverMenu.hide()
	drinkMenu.SetFalse()
	
	

func NewDay():
	print("Recieved")
	dayOverMenu.show()
	drinkMenu.SetFalse()
	
	
func StartNewDay():
	time_system.Unpause()
	dayOverMenu.hide()
	drinkMenu.SetFalse()
	if theSun:
		theSun.ResetDay()

	
	
