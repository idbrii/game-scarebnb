@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCBasil := preload("res://game/characters/basil/character_basil.gd")
# ---- classes

# nodes ----
var Basil: PCBasil : get = get_Basil
# ---- nodes

# functions ----
func get_Basil() -> PCBasil: return get_runtime_character("Basil")
# ---- functions

