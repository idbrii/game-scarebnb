@tool
extends "res://addons/popochiu/engine/interfaces/i_dialog.gd"

# classes ----
const PDPhonesHallChat := preload("res://game/dialogs/phones_hall_chat/dialog_phones_hall_chat.gd")
# ---- classes

# nodes ----
var PhonesHallChat: PDPhonesHallChat : get = get_PhonesHallChat
# ---- nodes

# functions ----
func get_PhonesHallChat() -> PDPhonesHallChat: return get_instance("PhonesHallChat")
# ---- functions

