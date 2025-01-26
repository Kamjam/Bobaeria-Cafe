extends  Node3D
@onready var time_system = $"../TimeSystem"
@onready var updgradeMenu = $"../UpgradeMenu"

func NewDay():
	print("Recieved")
	updgradeMenu.show()
	
	


func _on_start_new_day_button_down() -> void:
	time_system.Unpause()
	updgradeMenu.hide()
	
