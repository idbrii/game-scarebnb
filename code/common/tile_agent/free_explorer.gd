extends TileBoundedFreeMovement

@export var anim: BotAnim

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


func _ready() -> void:
    if not inputmap:
        printt("[Player] Creating fallback Bouton for player that consumes all inputs.", self)
        inputmap = Bouton.new(INPUT_MAP)


func _physics_process(dt: float) -> void:
    var motion = inputmap.get_vector("move")
    tick_cardinal_movement(motion, dt)


# ----


func get_inputmap() -> Bouton:
    return inputmap


# TileBoundedFreeMovement api

func _play_idle():
    anim.idle()


func _play_moving():
    anim.drive()


func _set_facing(is_flipped: bool):
    anim.set_facing(is_flipped)
