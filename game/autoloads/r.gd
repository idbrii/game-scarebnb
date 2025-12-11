@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRBedroom01 := preload("res://game/rooms/bedroom_01/room_bedroom_01.gd")
const PRHall01 := preload("res://game/rooms/hall_01/room_hall_01.gd")
# ---- classes

# nodes ----
var Bedroom01: PRBedroom01 : get = get_Bedroom01
var Hall01: PRHall01 : get = get_Hall01
# ---- nodes

# functions ----
func get_Bedroom01() -> PRBedroom01: return get_runtime_room("Bedroom01")
func get_Hall01() -> PRHall01: return get_runtime_room("Hall01")
# ---- functions

