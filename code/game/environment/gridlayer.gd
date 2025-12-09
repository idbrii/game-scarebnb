## Provides more functionality to a TileMapLayer.
##
## Adds a bunch of useful helper methods for any shape of TileMapLayer. You need to call configure() to use any GroundType
class_name GridLayer
extends TileMapLayer

const Dict = preload("res://code/util/dict.gd")
const Namer = preload("res://code/util/namer.gd")


## Map GroundType to the tile id in our TileSet. Allow setting cell contents
## via GroundType.
var ground_to_tile: Dictionary
## Map tile id to GroundType.
var tile_to_ground: Dictionary
## Map GroundType to colour for debug draw.
var ground_to_color: Dictionary
## Fill this out to autoset nodes under certain kinds of objects.
var group_to_tile: Dictionary


## Setup our mappings from GroundType (your enum of tile types) to the
## TileSet's Tile ID.
func configure(cfg):
    ground_to_tile = cfg.ground_to_tile
    tile_to_ground = Dict.invert_dict(ground_to_tile)
    ground_to_color = cfg.ground_to_color
    group_to_tile = cfg.group_to_tile

    snap_to_grid()


## Find the neighbour on the opposite side of the tile.
static func get_opposite_neighbor(neigh: TileSet.CellNeighbor) -> TileSet.CellNeighbor:
    match neigh:
        TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_SIDE:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_SIDE
        TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_SIDE:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_SIDE
        TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_SIDE:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_SIDE
        TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_SIDE:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_SIDE
        TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_LEFT_CORNER
        TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_RIGHT_CORNER
        TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_RIGHT_CORNER:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER
        TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_LEFT_CORNER:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER
        TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_CORNER:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_CORNER
        TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_LEFT_SIDE
        TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_CORNER:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_CORNER
        TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_RIGHT_SIDE
        TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_CORNER:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_CORNER
        TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_LEFT_SIDE:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE
        TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_CORNER:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_CORNER
        TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_RIGHT_SIDE:
            return TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE
        _:
            push_error("Invalid input neighbor: ", neigh)
            return TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_SIDE


## Useful for world-space offsets.
func get_cell_half_size() -> Vector2:
    return tile_set.tile_size / 2


## Snap all of our descendents in the snap_to_grid group to our grid.
## Additionally applies the group_to_tile parameter from configure().
func snap_to_grid():
    var layer := get_parent() as Node
    var targets = get_tree().get_nodes_in_group("snap_to_grid")
    for t in targets:
        if layer.is_ancestor_of(t):
            var cell_pos = global_to_cell_pos(t.global_position)
            var tile_type = _guess_tile_type(t)
            if tile_type != null:
                super.set_cell(cell_pos, ground_to_tile[tile_type], Vector2i.ZERO)
            t.global_position = cell_to_global_pos(cell_pos)


func _guess_tile_type(node: Node):
    for groupname in group_to_tile:
        if node.is_in_group(groupname):
            return group_to_tile[groupname]
    return null


## Returns a global position that's the bottom corner of a tile.
# https://www.reddit.com/r/godot/comments/fuejci/having_trouble_with_snapping_to_isometric_grid/fmcl07f/
func snap_global_to_cell(world_pos: Vector2) -> Vector2:
    # map_to_local says it's the centre, but it ignores texture_origin.
    return to_global(map_to_local(local_to_map(to_local(world_pos))))


## Convert a world position to a cell.
func global_to_cell_pos(world_pos: Vector2) -> Vector2i:
    return local_to_map(to_local(world_pos))


## Convert a cell to a world position.
func cell_to_global_pos(cell_pos: Vector2i) -> Vector2:
    return to_global(map_to_local(cell_pos))


## Adjusts a global cell position (bottom corner) to be centred within the cell.
func center_global_pos_in_cell(world_pos: Vector2) -> Vector2:
    var half = get_cell_half_size()
    half.x = 0
    return world_pos + half


## Adjusts a global position that's in the middle of a cell to the bottom corner.
func align_global_pos_in_cell(world_pos: Vector2) -> Vector2:
    var half = get_cell_half_size()
    half.x = 0
    return world_pos - half


#~ # https://github.com/gdquest-demos/godot-3-demos/blob/master/2017/final/09-Isometric%20grid-based%20movement/Player.gd
#~ func cartesian_to_isometric(point: Vector2) -> Vector2:
#~     return Vector2(point.x - point.y, (point.x + point.y) / 2)


## Set the TileMapLayer's raw "Tile ID" for the cell at world position v.
func set_world_cellv(pos: Vector2, value):
    var cell_space = global_to_cell_pos(pos)
    # It's unclear when atlas_coords is not zero.
    super.set_cell(cell_space, value, Vector2i.ZERO)


## Set the TileMapLayer's raw "Tile ID" for the cell at cell position v.
func set_groundtype(cell_pos: Vector2i, value):
    # It's unclear when atlas_coords is not zero.
    super.set_cell(cell_pos, ground_to_tile[value], Vector2i.ZERO)


## Set the TileMapLayer's raw "Tile ID" for the cell at world position v.
func set_world_groundtype(pos: Vector2, value):
    set_world_cellv(pos, ground_to_tile[value])


## Get the TileMapLayer's raw "Tile ID" from the cell at world position v.
func get_world_cellv(v: Vector2) -> int:
    var cell_space = global_to_cell_pos(v)
    var id = super.get_cell_source_id(cell_space)
    return id


## Get the configured GroundType for the cell at world position v.
func get_world_groundtype(v: Vector2) -> int:
    var id = get_world_cellv(v)
    return tile_to_ground[id]


## Get the configured GroundType for the cell at cell position v.
func get_groundtype(cell_pos: Vector2i):
    var value = super.get_cell_source_id(cell_pos)
    return tile_to_ground[value]


## Check for a tile at the input world position (that it's not empty).
func has_tile_at_world_pos(v: Vector2) -> int:
    var id = get_world_cellv(v)
    return id >= 0



## Add the player to this TileMapLayer so they'll ysort with our pieces and are
## positioned on one of our grid cells. To make the player start on our grid cell:
##   player.global_position = grid.attach_player_to_world(player)
func attach_player_to_world(player) -> Vector2:
    var old_grid = player.gridlayer
    var pos = player.global_position

    # HACK: Fix player attached one cell north of expected. I guess because
    # map_to_local doesn't return the centre? Applying centering again fixes it
    # although I'd expect to *remove* the centering, but it works.
    pos = center_global_pos_in_cell(pos)

    var dest = snap_global_to_cell(pos)
    player.get_parent().remove_child(player)
    add_child(player)
    player.gridlayer = self
    if old_grid:
        # To move from one TileMapLayer to another, we need to translate the
        # position.
        dest = cell_to_global_pos(old_grid.global_to_cell_pos(dest))
    return center_global_pos_in_cell(dest)


## Call from a Node2D:
##   fun _draw():
##       grid.debug_draw_tiles(self)
func debug_draw_tiles(pen: CanvasItem):
    var size = Vector2(5, 5)
    for x in range(-100, 100):
        for y in range(-100, 100):
            var cell = Vector2(x, y)
            var pos = cell_to_global_pos(cell)
            var ground = get_world_cellv(pos)
            var c = ground_to_color[ground]
            pen.draw_rect(Rect2(pos, size), c)


## Create a bunch of markers to show the valid neighbours for the current grid
## type.
func create_cell_neighbor_position_markers(target_root):
    var current_cell = global_to_cell_pos(target_root.global_position)
    const LAST_NEIGHBOR = TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_RIGHT_CORNER
    for n in range(LAST_NEIGHBOR + 1):
        var cell = get_neighbor_cell(current_cell, n)
        var pos = cell_to_global_pos(cell)
        var marker = Label.new()
        target_root.add_child(marker)
        # Neighbors that don't exist in your TileShape will be in current_cell.
        marker.global_position = pos
        marker.name = Namer.find_native_enum_label("TileSet", "CellNeighbor", n)
        marker.text = "X"
        var label = Label.new()
        marker.add_child(label)
        label.text = marker.name
        label.position = Vector2.UP * 10
        label.scale = Vector2.ONE * 0.5

