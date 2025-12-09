extends HexMovement

const CELL_NEIGHBOR_INVALID : int = -1

const Namer = preload("res://code/util/namer.gd")


var INPUT_MAP := {
    "gamepad":
    {
        "controls":
        {
            "interact": [JOY_BUTTON_A],
            "exit": [JOY_BUTTON_B],
            "cycle_left": [JOY_BUTTON_LEFT_SHOULDER],
            "cycle_right": [JOY_BUTTON_RIGHT_SHOULDER],
            "walk_left": [Bouton.JoyAxis(JOY_AXIS_LEFT_X, -1)],
            "walk_right": [Bouton.JoyAxis(JOY_AXIS_LEFT_X, 1)],
            "walk_up": [Bouton.JoyAxis(JOY_AXIS_LEFT_Y, -1)],
            "walk_down": [Bouton.JoyAxis(JOY_AXIS_LEFT_Y, 1)],
        },
        "device": 0,
    },
    "keyboard":
    {
        "controls":
        {
            "interact": [KEY_SPACE],
            "exit": [KEY_ESCAPE],
            "walk_left": [KEY_A, KEY_LEFT],
            "walk_right": [KEY_D, KEY_RIGHT],
            "walk_up": [KEY_W, KEY_UP],
            "walk_down": [KEY_S, KEY_DOWN],
        },
    },
    "pairs":
    {
        "horizontal": ["walk_left", "walk_right"],
        "vertical": ["walk_down", "walk_up"],
        "cycle": ["cycle_left", "cycle_right"],
    },
    "quads":
    {
        "move": ["walk_left", "walk_right", "walk_down", "walk_up"],
    },
    "deadzone": 0.5,
}

var inputmap: Bouton


## Setup a global input handler for a player spawn input, instantiate your
## player, and call this on them before add_child.
func setup_input(event: InputEvent):
    inputmap = Bouton.new(Bouton.filter_for_input_device(INPUT_MAP, event))


func vent_init(player: Node2D):
    super.vent_init(player)
    if not inputmap:
        printt("[Player] Creating fallback Bouton for player that consumes all inputs.", self)
        inputmap = Bouton.new(INPUT_MAP)
    anim.idle()


# Map the input to a world-space position.
func input_dir_to_dest(input_dir: Vector2):
    var neighbor = input_dir_to_neighbor_for_right_flat_hex(input_dir)
    if neighbor > CELL_NEIGHBOR_INVALID:
        var current_cell : Vector2i = gridlayer.global_to_cell_pos(global_position)
        var cell := gridlayer.get_neighbor_cell(current_cell, neighbor)
        return gridlayer.cell_to_global_pos(cell)
    return global_position



func _matches_grid_angle(input_dir: Vector2, direction: Vector2) -> bool:
    # Divide circle of possible inputs into one segment for each side of our
    # grid shape.
    var segment := TAU/6 * 0.5
    var a = input_dir.angle_to(direction)
    return abs(a) < segment


func _input_dir_to_neighbor_internal(input_dir: Vector2, base_direction: Vector2, neighbors):
    # For our overhead hexmap, we check the input angle against a wedge at each
    # of the 6 sides of the hex.
    const HEX_DELTA = TAU / 6

    # Each neighbour specifies an additional HEX_DELTA rotation from
    # base_direction.
    for i in neighbors.size():
        if _matches_grid_angle(input_dir, base_direction.rotated(HEX_DELTA * i)):
            return neighbors[i]

    printt("input_dir_to_neighbor: failed to find a match.")
    return CELL_NEIGHBOR_INVALID


## For an overhead hexmap with flat sides.
func input_dir_to_neighbor_for_right_flat_hex(input_dir: Vector2):
    return _input_dir_to_neighbor_internal(
        input_dir,
        Vector2.RIGHT,  # A flat side.
        [
            TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_SIDE,
            TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE,
            TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE,
            TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_SIDE,
            TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_LEFT_SIDE,
            TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_RIGHT_SIDE,
    ])


## For an overhead hexmap with flat top and bottom.
func input_dir_to_neighbor_for_top_flat_hex(input_dir: Vector2):
    return _input_dir_to_neighbor_internal(
        input_dir,
        Vector2.DOWN,  # A flat side.
        [
            TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_SIDE,
            TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE,
            TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_LEFT_SIDE,
            TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_SIDE,
            TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_RIGHT_SIDE,
            TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE,
    ])



func tick(_dt: float, player: Node2D):
    var motion := inputmap.get_vector("move")

    # If your perspective was closer to isometric, you should rotate the input
    # to match the iso projection so you correctly interpret diagonal inputs:
    # var iso_motion := motion.rotated(TAU * 1/10)
    var iso_motion := motion
    # Use a hefty deadzone since movement is discrete.
    const DEADZONE_SQ = 0.3*0.3
    var want_movement := iso_motion.length_squared() > DEADZONE_SQ
    $DestinationPointer.visible = want_movement
    $DestinationMarker.visible = want_movement
    $Effort.emitting = want_movement
    if want_movement:
        var dest = input_dir_to_dest(iso_motion)
        var delta = dest - player.global_position

        $DestinationMarker.global_position = dest

        # Display snapped input direction.
        $DestinationPointer.rotation = -delta.angle_to(Vector2.RIGHT)
        # Display exact input direction.
        #~ $DestinationPointer.rotation = -motion.angle_to(Vector2.RIGHT)

        if block_input:
            return

        dest = gridlayer.snap_global_to_cell(dest)

        apply_facing_direction(delta)

        move_async(player, dest, delta)

