extends PopochiuSettingsBarButton

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Godot ░░░░ {{{1
func _ready() -> void:
	super()
	
	if OS.has_feature("web"):
		hide()



