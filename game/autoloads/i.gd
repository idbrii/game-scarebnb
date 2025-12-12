@tool
extends "res://addons/popochiu/engine/interfaces/i_inventory.gd"

# classes ----
const PIICoin := preload("res://game/inventory_items/coin/inventory_item_coin.gd")
const PIILetter := preload("res://game/inventory_items/letter/inventory_item_letter.gd")
const PIISheet := preload("res://game/inventory_items/sheet/inventory_item_sheet.gd")
const PIILicense := preload("res://game/inventory_items/license/inventory_item_license.gd")
const PIIMagazine := preload("res://game/inventory_items/magazine/inventory_item_magazine.gd")
const PIISketch := preload("res://game/inventory_items/sketch/inventory_item_sketch.gd")
const PIISoundBloop := preload("res://game/inventory_items/sound_bloop/inventory_item_sound_bloop.gd")
# ---- classes

# nodes ----
var Coin: PIICoin : get = get_Coin
var Letter: PIILetter : get = get_Letter
var Sheet: PIISheet : get = get_Sheet
var License: PIILicense : get = get_License
var Magazine: PIIMagazine : get = get_Magazine
var Sketch: PIISketch : get = get_Sketch
var SoundBloop: PIISoundBloop : get = get_SoundBloop
# ---- nodes

# functions ----
func get_Coin() -> PIICoin: return get_item_instance("Coin")
func get_Letter() -> PIILetter: return get_item_instance("Letter")
func get_Sheet() -> PIISheet: return get_item_instance("Sheet")
func get_License() -> PIILicense: return get_item_instance("License")
func get_Magazine() -> PIIMagazine: return get_item_instance("Magazine")
func get_Sketch() -> PIISketch: return get_item_instance("Sketch")
func get_SoundBloop() -> PIISoundBloop: return get_item_instance("SoundBloop")
# ---- functions

