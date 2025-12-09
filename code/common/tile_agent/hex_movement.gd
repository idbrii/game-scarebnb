class_name HexMovement
extends Node2D

signal completed_attack()
signal completed_move()

enum GroundType {
    EMPTY,
    SOLID,
}

@export var anim : BotAnim
@export var move_duration : float = 0.5

var gridlayer : GridLayer
var block_input := false
var current_facing_flip := false


func vent_init(bot: Node2D):
    gridlayer = bot.gridlayer

    var cfg = {
        # Map GroundType to the tile id in our TileSet.
        ground_to_tile = {
            # TODO: Fill this out.
            GroundType.EMPTY: -1,
            GroundType.SOLID: 0,
        },

        ground_to_color = {
            GroundType.EMPTY: Color.WHITE,
            GroundType.SOLID: Color.RED,
        },

        group_to_tile = {
            "solid": GroundType.SOLID,
        },
    }
    gridlayer.configure(cfg)

    # Ensure we start in the middle of our grid cell.
    bot.global_position = gridlayer.snap_global_to_cell(bot.global_position)
    assert(position.length() < 0.01, "Don't move player_hexmovement.")


func apply_facing_direction(action_direction: Vector2):
    var r_dot := action_direction.dot(Vector2.RIGHT)
    var flip_h := r_dot <= 0
    if absf(r_dot) > 0 and flip_h != current_facing_flip:
        current_facing_flip = flip_h
        anim.set_facing(current_facing_flip)


func move_async(bot: Node2D, dest: Vector2, delta: Vector2):
    var dest_tile = GroundType.EMPTY
    var has_tile = gridlayer.has_tile_at_world_pos(dest)
    if has_tile:
        dest_tile = GroundType.SOLID

    block_input = true
    anim.drive()

    var tween := create_tween()
    match dest_tile:
        GroundType.SOLID:
            var t := tween.tween_property(bot, "global_position", delta, move_duration)
            t = t.from_current()
            t = t.as_relative()
            t = t.set_ease(Tween.EASE_IN_OUT)
            t = t.set_trans(Tween.TRANS_SINE)

        _:
            # Bounce off collision to give feedback that we recognized the input but it was invalid.
            var duration := move_duration * 0.1
            var current_pos := bot.global_position
            var t := tween.tween_property(bot, "global_position", delta * 0.1, duration)
            t = t.from_current()
            t = t.as_relative()
            t = t.set_ease(Tween.EASE_IN_OUT)
            t = t.set_trans(Tween.TRANS_SINE)
            t = tween.chain().tween_property(bot, "global_position", current_pos, duration)
            t = t.from_current()
            t = t.set_ease(Tween.EASE_IN_OUT)
            t = t.set_trans(Tween.TRANS_SINE)

    await tween.finished

    anim.idle()
    block_input = false
    completed_move.emit(1)


func attack_async(bot: Node2D, dest: Vector2, delta: Vector2):
    # TODO: Show different anim for "ready to attack" and "firing"
    anim.attack()

    var cell = gridlayer.global_to_cell_pos(dest)
    var enemy = bot.enemy_controller.get_robot(cell)

    var want_fire = bot.get_inputmap().is_action_just_pressed("confirm_target")
    if want_fire and not enemy:
        # Misfire.
        printt("Ending attack early.")
        anim.idle()
        completed_attack.emit()
        return


    if not want_fire:
        # Just aiming.
        return

    block_input = true

    # Shake a bit to indicate launching our attack.
    var tween := create_tween()
    var duration := move_duration * 0.1
    var current_pos := bot.global_position
    var t := tween.tween_property(bot, "global_position", delta * 0.1, duration)
    t = t.from_current()
    t = t.as_relative()
    t = t.set_ease(Tween.EASE_IN_OUT)
    t = t.set_trans(Tween.TRANS_SINE)
    t = tween.chain().tween_property(bot, "global_position", current_pos, duration)
    t = t.from_current()
    t = t.set_ease(Tween.EASE_IN_OUT)
    t = t.set_trans(Tween.TRANS_SINE)

    await tween.finished
    await get_tree().create_timer(0.1).timeout
    anim.idle()
    await enemy.take_damage(1)

    block_input = false
    completed_attack.emit()

