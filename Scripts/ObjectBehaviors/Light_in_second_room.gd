extends Node2D

func _ready():
	add_to_group("secondLight")
	
func TurnOn():
	self.show()
