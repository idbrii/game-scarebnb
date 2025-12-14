class_name Animators


## Very basic alpha fade_in using modulate. To use from() or other fancy
## options, create the tween yourself.
static func fade_in(node: Node, fade_duration := 1.0):
    var tween = node.get_tree().create_tween()
    tween.tween_property(node, "modulate:a", 1, fade_duration)
    tween.play()
    await tween.finished


static func fade_out(node: Node, fade_duration := 1.0):
    var tween = node.get_tree().create_tween()
    tween.tween_property(node, "modulate:a", 0, fade_duration)
    tween.play()
    await tween.finished
