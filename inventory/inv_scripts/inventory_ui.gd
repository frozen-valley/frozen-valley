extends Control

@onready var inv: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $GridContainer.get_children()


var is_journal_open := false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
func close_journal():
	is_journal_open = false
	$GridContainer.show()
	$InventoryTexture.show()

func open_journal():
	is_journal_open = true
	$GridContainer.hide()
	$InventoryTexture.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("book"):
		if is_journal_open:
			close_journal()
		else:
			open_journal()
