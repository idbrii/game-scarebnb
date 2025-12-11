@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCBasil := preload("res://game/characters/basil/character_basil.gd")
const PCBlanketGhost := preload("res://game/characters/blanket_ghost/character_blanket_ghost.gd")
const PCHeadphoneGhost := preload("res://game/characters/headphone_ghost/character_headphone_ghost.gd")
# ---- classes

# nodes ----
var Basil: PCBasil : get = get_Basil
var BlanketGhost: PCBlanketGhost : get = get_BlanketGhost
var HeadphoneGhost: PCHeadphoneGhost : get = get_HeadphoneGhost
# ---- nodes

# functions ----
func get_Basil() -> PCBasil: return get_runtime_character("Basil")
func get_BlanketGhost() -> PCBlanketGhost: return get_runtime_character("BlanketGhost")
func get_HeadphoneGhost() -> PCHeadphoneGhost: return get_runtime_character("HeadphoneGhost")
# ---- functions

