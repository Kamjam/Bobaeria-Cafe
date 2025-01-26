extends  Node3D
@onready var time_system = $"../TimeSystem"
@onready var updgradeMenu = $"../UpgradeMenu"
@onready var drinkMenu =  $"../NavigationRegion3D/Machine"
@onready var theSun = $"../THE SUN"

func _ready() -> void:
	updgradeMenu.hide()
	drinkMenu.SetFalse()

func NewDay():
	print("Recieved")
	updgradeMenu.show()
	drinkMenu.SetFalse()
	
	


func _on_start_new_day_button_down() -> void:
	time_system.Unpause()
	updgradeMenu.hide()
	drinkMenu.SetFalse()
	if theSun:
		theSun.ResetDay()
	
