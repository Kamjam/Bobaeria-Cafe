extends  Node3D
@onready var time_system = $"../TimeSystem"
@onready var dayOverMenu = $"../Day Over Screen"
@onready var drinkMenu =  $"../NavigationRegion3D/Table9"
@onready var theSun = $"../THE SUN"
@onready var Spawner = $"../Spawn"

@export var text_drinksGiven : Label
@export var text_drinksMade : Label
@export var text_drinksBubbled : Label

@export var text_Days : Label
@export var fade : PackedScene	
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
	var a = fade.instantiate()
	add_child(a)
	dayCount += 1
	text_Days.text = str(dayCount)
	print("Recieved")
	drinkMenu.SetFalse()
	await get_tree().create_timer(1.5).timeout
	dayOverMenu.show()

	
func StartNewDay():
	var a = fade.instantiate()
	add_child(a)
	time_system.Unpause()
	drinkMenu.SetFalse()
	if theSun:
		theSun.ResetDay()
	await get_tree().create_timer(1.5).timeout
	dayOverMenu.hide()
	

	
	
