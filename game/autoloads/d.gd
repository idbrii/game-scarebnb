@tool
extends "res://addons/popochiu/engine/interfaces/i_dialog.gd"

# classes ----
const PDPhonesHallChat := preload("res://game/dialogs/phones_hall_chat/dialog_phones_hall_chat.gd")
const PDEvanHomeNoiseComplaint := preload("res://game/dialogs/evan_home_noise_complaint/dialog_evan_home_noise_complaint.gd")
# ---- classes

# nodes ----
var PhonesHallChat: PDPhonesHallChat : get = get_PhonesHallChat
var EvanHomeNoiseComplaint: PDEvanHomeNoiseComplaint : get = get_EvanHomeNoiseComplaint
# ---- nodes

# functions ----
func get_PhonesHallChat() -> PDPhonesHallChat: return get_instance("PhonesHallChat")
func get_EvanHomeNoiseComplaint() -> PDEvanHomeNoiseComplaint: return get_instance("EvanHomeNoiseComplaint")
# ---- functions
