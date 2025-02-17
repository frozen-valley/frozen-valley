class_name Inventory
extends Resource

signal update

@export var slots: Array[InventorySlot]

func has_item(item_name: String) -> bool:
	for item: InventorySlot in slots:
		if (!item.item):
			continue
		if (item.item.name == item_name):
			return true
	return false

func insert(item: InventoryItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
	update.emit()

func remove(item: InventoryItem):
	var invItemCounter: int = 0
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	for invItem in itemSlots:
		invItemCounter += 1
		if invItem.name == item.name:
			itemSlots[invItemCounter].amount -=1
	update.emit()

func remove_key():
	var invItemCounter: int = 0
	var itemSlots = slots.filter(func(slot): if slot.item != null: return slot.item.name == "key")
	for invItem: InventorySlot in itemSlots:
		if invItem != null and invItem.item.name == "key":
			itemSlots[invItemCounter].item = null
		invItemCounter += 1
	update.emit()
