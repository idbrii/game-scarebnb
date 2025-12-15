class_name ScareInventoryItem
extends PopochiuInventoryItem

## Has the player ever collected this item.
var has_collected := false


func _on_added_to_inventory():
    has_collected = true

func can_collect():
    # Every item is only collected once.
    return not has_collected
