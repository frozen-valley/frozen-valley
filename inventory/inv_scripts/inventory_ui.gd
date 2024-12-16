extends Control

@onready var inv: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


var is_open := false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
func close():
	visible = false
	is_open = false

func open():
	visible = true
	is_open = true
