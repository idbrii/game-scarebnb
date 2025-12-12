@tool
extends "res://addons/popochiu/engine/interfaces/i_dialog.gd"

# classes ----
const PDPhonesHallChat := preload("res://game/dialogs/phones_hall_chat/dialog_phones_hall_chat.gd")
const PDEvanHomeNoiseComplaint := preload("res://game/dialogs/evan_home_noise_complaint/dialog_evan_home_noise_complaint.gd")
const PDDapperHomeJoke := preload("res://game/dialogs/dapper_home_joke/dialog_dapper_home_joke.gd")
const PDDapperHomeIntro := preload("res://game/dialogs/dapper_home_intro/dialog_dapper_home_intro.gd")
# ---- classes

# nodes ----
var PhonesHallChat: PDPhonesHallChat : get = get_PhonesHallChat
var EvanHomeNoiseComplaint: PDEvanHomeNoiseComplaint : get = get_EvanHomeNoiseComplaint
var DapperHomeJoke: PDDapperHomeJoke : get = get_DapperHomeJoke
var DapperHomeIntro: PDDapperHomeIntro : get = get_DapperHomeIntro
# ---- nodes

# functions ----
func get_PhonesHallChat() -> PDPhonesHallChat: return get_instance("PhonesHallChat")
func get_EvanHomeNoiseComplaint() -> PDEvanHomeNoiseComplaint: return get_instance("EvanHomeNoiseComplaint")
func get_DapperHomeJoke() -> PDDapperHomeJoke: return get_instance("DapperHomeJoke")
func get_DapperHomeIntro() -> PDDapperHomeIntro: return get_instance("DapperHomeIntro")
# ---- functions
