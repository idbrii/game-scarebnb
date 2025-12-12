@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRHall01 := preload("res://game/rooms/hall_01/room_hall_01.gd")
const PRFrontDesk := preload("res://game/rooms/front_desk/room_front_desk.gd")
const PRHall02 := preload("res://game/rooms/hall_02/room_hall_02.gd")
const PRNauticalRoom := preload("res://game/rooms/nautical_room/room_nautical_room.gd")
const PRHorseRoom := preload("res://game/rooms/horse_room/room_horse_room.gd")
const PRCircusRoom := preload("res://game/rooms/circus_room/room_circus_room.gd")
# ---- classes

# nodes ----
var Hall01: PRHall01 : get = get_Hall01
var FrontDesk: PRFrontDesk : get = get_FrontDesk
var Hall02: PRHall02 : get = get_Hall02
var NauticalRoom: PRNauticalRoom : get = get_NauticalRoom
var HorseRoom: PRHorseRoom : get = get_HorseRoom
var CircusRoom: PRCircusRoom : get = get_CircusRoom
# ---- nodes

# functions ----
func get_Hall01() -> PRHall01: return get_runtime_room("Hall01")
func get_FrontDesk() -> PRFrontDesk: return get_runtime_room("FrontDesk")
func get_Hall02() -> PRHall02: return get_runtime_room("Hall02")
func get_NauticalRoom() -> PRNauticalRoom: return get_runtime_room("NauticalRoom")
func get_HorseRoom() -> PRHorseRoom: return get_runtime_room("HorseRoom")
func get_CircusRoom() -> PRCircusRoom: return get_runtime_room("CircusRoom")
# ---- functions

