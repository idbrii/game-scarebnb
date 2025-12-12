@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCBasil := preload("res://game/characters/basil/character_basil.gd")
const PCHeadphoneGhost := preload("res://game/characters/headphone_ghost/character_headphone_ghost.gd")
const PCDapperGhost := preload("res://game/characters/dapper_ghost/character_dapper_ghost.gd")
const PCGrannyGhost := preload("res://game/characters/granny_ghost/character_granny_ghost.gd")
# ---- classes

# nodes ----
var Basil: PCBasil : get = get_Basil
var HeadphoneGhost: PCHeadphoneGhost : get = get_HeadphoneGhost
var DapperGhost: PCDapperGhost : get = get_DapperGhost
var GrannyGhost: PCGrannyGhost : get = get_GrannyGhost
# ---- nodes

# functions ----
func get_Basil() -> PCBasil: return get_runtime_character("Basil")
func get_HeadphoneGhost() -> PCHeadphoneGhost: return get_runtime_character("HeadphoneGhost")
func get_DapperGhost() -> PCDapperGhost: return get_runtime_character("DapperGhost")
func get_GrannyGhost() -> PCGrannyGhost: return get_runtime_character("GrannyGhost")
# ---- functions

