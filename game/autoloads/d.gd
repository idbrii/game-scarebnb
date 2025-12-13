@tool
extends "res://addons/popochiu/engine/interfaces/i_dialog.gd"

# classes ----
const PDPhonesHallChat := preload("res://game/dialogs/phones_hall_chat/dialog_phones_hall_chat.gd")
const PDEvanHomeNoiseComplaint := preload("res://game/dialogs/evan_home_noise_complaint/dialog_evan_home_noise_complaint.gd")
const PDDapperJokeCar := preload("res://game/dialogs/dapper_joke_car/dialog_dapper_joke_car.gd")
const PDDapperHomeIntro := preload("res://game/dialogs/dapper_home_intro/dialog_dapper_home_intro.gd")
const PDDapperJokeSheet := preload("res://game/dialogs/dapper_joke_sheet/dialog_dapper_joke_sheet.gd")
# ---- classes

# nodes ----
var PhonesHallChat: PDPhonesHallChat : get = get_PhonesHallChat
var EvanHomeNoiseComplaint: PDEvanHomeNoiseComplaint : get = get_EvanHomeNoiseComplaint
var DapperJokeCar: PDDapperJokeCar : get = get_DapperJokeCar
var DapperHomeIntro: PDDapperHomeIntro : get = get_DapperHomeIntro
var DapperJokeSheet: PDDapperJokeSheet : get = get_DapperJokeSheet
# ---- nodes

# functions ----
func get_PhonesHallChat() -> PDPhonesHallChat: return get_instance("PhonesHallChat")
func get_EvanHomeNoiseComplaint() -> PDEvanHomeNoiseComplaint: return get_instance("EvanHomeNoiseComplaint")
func get_DapperJokeCar() -> PDDapperJokeCar: return get_instance("DapperJokeCar")
func get_DapperHomeIntro() -> PDDapperHomeIntro: return get_instance("DapperHomeIntro")
func get_DapperJokeSheet() -> PDDapperJokeSheet: return get_instance("DapperJokeSheet")
# ---- functions
