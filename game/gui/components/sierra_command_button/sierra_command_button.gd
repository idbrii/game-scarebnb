extends TextureButton

@export var command: SierraCommands.Commands = 0


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Godot ░░░░ {{{1
func _ready() -> void:
	toggled.connect(on_toggled)




# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Public ░░░░ {{{1
func on_toggled(is_pressed: bool) -> void:
	if is_pressed:
		PopochiuUtils.e.current_command = command



