@tool
extends "res://addons/popochiu/engine/interfaces/i_inventory.gd"

# classes ----
const PIICoin := preload("res://game/inventory_items/coin/inventory_item_coin.gd")
const PIILetter := preload("res://game/inventory_items/letter/inventory_item_letter.gd")
# ---- classes

# nodes ----
var Coin: PIICoin : get = get_Coin
var Letter: PIILetter : get = get_Letter
# ---- nodes

# functions ----
func get_Coin() -> PIICoin: return get_item_instance("Coin")
func get_Letter() -> PIILetter: return get_item_instance("Letter")
# ---- functions

