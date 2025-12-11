@tool
extends "res://addons/popochiu/engine/interfaces/i_inventory.gd"

# classes ----
const PIICoin := preload("res://game/inventory_items/coin/inventory_item_coin.gd")
# ---- classes

# nodes ----
var Coin: PIICoin : get = get_Coin
# ---- nodes

# functions ----
func get_Coin() -> PIICoin: return get_item_instance("Coin")
# ---- functions

