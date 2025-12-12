extends PopochiuDialogText


#region Private ####################################################################################
func _modify_size(msg: String, target_position: Vector2) -> void:
	var computed_size := await _calculate_size(msg)

	# Define size and position (before calculating overflow)

	# HACK: This wasn't constraining the width of the text, so set x as well.
	# Use the target to figure out where to position, but we need to adjust for
	# the size of the text so it still lines up with the "Dialog Position".
	# There's some default height and using 150 makes it line up okay.
	rich_text_label.size = computed_size
	rich_text_label.position = target_position + Vector2(-computed_size.x/2, 150.0 - computed_size.y/2)


func _append_text(msg: String, props: Dictionary) -> void:
	rich_text_label.text = "[center][color=%s]%s[/color][/center]" % [props.color.to_html(), msg]
