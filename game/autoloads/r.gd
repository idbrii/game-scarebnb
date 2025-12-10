@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRBedroom01 := preload("res://game/rooms/bedroom_01/room_bedroom_01.gd")
# ---- classes

# nodes ----
var Bedroom01: PRBedroom01 : get = get_Bedroom01
# ---- nodes

# functions ----
func get_Bedroom01() -> PRBedroom01: return get_runtime_room("Bedroom01")
# ---- functions

