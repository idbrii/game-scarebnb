class_name TileBoundedFreeMovement
extends CharacterBody2D

const TAN30DEG: float = tan(deg_to_rad(30.0))

@export var friction_factor: float = 0.89
@export var motion_speed: float = 30.0
@export var gridlayer: GridLayer

var current_facing_flip := false


## Movement where motion represents movement in cardinal directions (as opposed
## to world-space directions). Call from _physics_process.
func tick_cardinal_movement(motion: Vector2, dt: float) -> void:
    # Make diagonal movement fit for hexagonal tiles.
    motion.y *= -TAN30DEG
    tick_worldspace_movement(motion, dt)


## Call from _physics_process.
func tick_worldspace_movement(motion: Vector2, _dt: float) -> void:
    var prev_position: Vector2 = global_position

    var delta = motion.normalized() * motion_speed
    velocity += delta
    # Apply friction.
    velocity *= friction_factor
    move_and_slide()

    apply_facing_direction(delta)
    # HACK: 100 seems huge but stops wheels when we appear to stop moving. Scale must be weird?
    if velocity.length_squared() < 100.0:
        _play_idle()
    else:
        _play_moving()

    # Prevent movement off of the grid tiles. Alternatively, you could add a
    # border tile around the outside of your world with physics enabled in the
    # TileMapLayer. That would allow nice sliding along the walls of the world.
    var dest_tile: int = gridlayer.get_world_cellv(global_position)
    # HACK:
    # -1 means there's no tile (empty space)
    # 0 means it's a building
    var has_tile: bool = dest_tile > 0
    if not has_tile:
        global_position = prev_position


# ----


func apply_facing_direction(action_direction: Vector2):
    var r_dot := action_direction.dot(Vector2.RIGHT)
    var flip_h := r_dot <= 0
    if absf(r_dot) > 0 and flip_h != current_facing_flip:
        current_facing_flip = flip_h
        _set_facing(current_facing_flip)


#
# Subclass api


func _play_idle():
    pass


func _play_moving():
    pass


func _set_facing(_is_flipped: bool):
    pass
