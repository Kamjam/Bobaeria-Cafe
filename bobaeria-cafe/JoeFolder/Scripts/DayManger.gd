extends  Node3D
@onready var time_system = $"../TimeSystem"
@onready var dayOverMenu = $"../Day Over Screen"
@onready var drinkMenu =  $"../NavigationRegion3D/Table9"
@onready var theSun = $"../THE SUN"

@export var text_drinksGiven : Label
@export var text_drinksMade : Label
@export var text_drinksBubbled : Label

@export var text_Days : Label

var drinksGiven : int = 0
var drinksMade : int = 0
var drinksBubbled : int = 0

var dayCount : int = 0
func SetGiven():
	drinksGiven += 1
	text_drinksGiven.text = str(drinksGiven)

func SetMade():
	drinksMade += 1
	text_drinksMade.text = str(drinksMade)
	
func SetBubbled():
	drinksBubbled += 1
	text_drinksBubbled.text = str(drinksBubbled)
func _ready() -> void:
	dayOverMenu.hide()
	drinkMenu.SetFalse()
	
	

func NewDay():
	dayCount += 1
	text_Days.text = str(dayCount)
	print("Recieved")
	dayOverMenu.show()
	drinkMenu.SetFalse()
	
	
func StartNewDay():
	time_system.Unpause()
	dayOverMenu.hide()
	drinkMenu.SetFalse()
	if theSun:
		theSun.ResetDay()

	
	
