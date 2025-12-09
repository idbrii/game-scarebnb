# Margin ensures our ColorRect fills the space allowed.
class_name FullScreenTransition
extends MarginContainer

@export var transition_duration := 1.0

@onready var surface := $ColorRect

var max_progress := 1.0


func _ready():
    # We only exist to fill our space.
    add_theme_constant_override("margin_left", 0)
    add_theme_constant_override("margin_right", 0)
    add_theme_constant_override("margin_top", 0)
    add_theme_constant_override("margin_bottom", 0)

    # TODO: Create the ColorRect so I don't need to configure it in the scene.


func start_transition_in():
    await _start_transition(0.0, max_progress)


func start_transition_out():
    await _start_transition(max_progress, 0.0)


func _start_transition(begin: float, end: float):
    var tween: Tween = create_tween()
    tween.tween_method(set_shader_progress, begin, end, transition_duration)
    await tween.finished


## Use as a transition in and out of playing a video.
func play_video(video: VideoResource, container: VideoContainer):
    container.play_video(video)
    # Delay a frame to get something visible.
    await get_tree().create_timer(0).timeout
    container.player.paused = true
    self.randomize_transition()

    # Don't await transition so we can start when it's almost done.
    self.start_transition_in()
    await get_tree().create_timer(self.transition_duration * 0.5).timeout

    container.player.paused = false

    await container.player.finished
    container.player.paused = true
    await self.start_transition_out()
    container.player.stop()


func set_shader_progress(value: float):
    set_shader_param("progress", value)


func set_shader_param(key: String, value):
    surface.material.set_shader_parameter(key, value)


func reset_transition():
    # Reset all uniforms so we don't need to fully configure them.
    set_shader_param("position", Vector2.ZERO)
    set_shader_param("invert", false)
    set_shader_param("grid_size", Vector2.ONE)
    set_shader_param("rotation_angle", 0.0)
    set_shader_param("stagger", Vector2.ZERO)
    set_shader_param("stagger_frequency", Vector2i(2, 2))
    set_shader_param("flip_frequency", Vector2i(1, 1))
    set_shader_param("basic_feather", 0.0)
    set_shader_param("mask_texture", null)
    set_shader_param("use_mask_size", false)
    set_shader_param("mask_size", Vector2.ONE * 100.0)
    set_shader_param("edges", 6)
    set_shader_param("shape_feather", 0.1)
    set_shader_param("sectors", 1)
    set_shader_param("clock_feather", 0.0)
    set_shader_param("progress", 0.0)
    set_shader_param("progress_bias", Vector2.ZERO)
    max_progress = 1


func randomize_transition():
    var fn = Random.choose_value(CONFIG_FNS)

    printt("ShaderTransition:", fn)
    reset_transition()
    call(fn)


var last_idx = 0
func next_transition():
    var fn = CONFIG_FNS[last_idx % CONFIG_FNS.size()]
    last_idx += 1

    printt("ShaderTransition:", fn)
    reset_transition()
    call(fn)


enum TransitionType {
    # Must match transition.gdshader:
    # uniform int transition_type: hint_enum("Basic", "Mask", "Shape", "Clock") = 0;
    BASIC,
    MASK,
    SHAPE,
    CLOCK
}

const CONFIG_FNS = [
    "config_SimpleFade",
    "config_DirectionalWipe",
    "config_CornerWipe",
    "config_DiagonalWipe",
    "config_CenterWipe",
    "config_BlinderWipe",
    "config_GridReveal",
    "config_StaggeredGridReveal",
    "config_MixedStaggerReveal",
    "config_AllCornersWipe",
    "config_DiagonalPoppingSquares",
    "config_StepWipe",
]


# Config functions are pulled from the Common Transition Recipes
# https://github.com/cashew-olddew/Universal-Transition-Shader?tab=readme-ov-file#common-transition-recipes
func config_SimpleFade():
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("grid_size", Vector2(0.0, 0.0))
    set_shader_param("basic_feather", 1)  # Any value > 0.0


func config_DirectionalWipe():
    # HACK: Some don't complete transition at 1.
    max_progress = 2
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("grid_size", Vector2(1.0, 0.0))  #  or (0.0, 1.0) or (-1.0, 0.0) or (0.0, -1.0)


func config_CornerWipe():
    max_progress = 2
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("grid_size", Vector2(1.0, 1.0))  #  or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)


func config_DiagonalWipe():
    max_progress = 4
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("grid_size", Vector2(1.0, 1.0))  #  or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)
    set_shader_param("rotation_angle", 45.0)


func config_CenterWipe():
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("position", Vector2(0.5, 0.5))


func config_BlinderWipe():
    max_progress = 2
    # (0, abs(y) > 2.0) or (abs(x) > 2.0, 0.0)
    var y := 4.0
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("grid_size", Vector2(0.0, y))


func config_GridReveal():
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("position", Vector2(0.5, 0.5))
    set_shader_param("grid_size", Vector2(10.0, 10.0))  #  - or any abs(x) > 0.0; abs(y) > 0.0;


func config_StaggeredGridReveal():
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("position", Vector2(0.5, 0.5))
    set_shader_param("grid_size", Vector2(10.0, 10.0))  #  - or any abs(x) > 0.0; abs(y) > 0.0;
    set_shader_param("stagger", Vector2(1.0, 0.0))  #  or (0.0, 1.0)


func config_MixedStaggerReveal():
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("position", Vector2(0.5, 0.5))
    set_shader_param("grid_size", Vector2(5.0, 5.0))
    set_shader_param("stagger", Vector2(1.0, 1.0))


## Cross-shaped Transition
func config_AllCornersWipe():
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("position", Vector2(0.5, 0.5))
    set_shader_param("stagger", Vector2(1.0, 1.0))


func config_DiagonalPoppingSquares():
    max_progress = 9
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("position", Vector2(0.5, 0.5))
    set_shader_param("grid_size", Vector2(5.0, 5.0))
    set_shader_param("progress_bias", Vector2(10.0, 10.0))


func config_StepWipe():
    max_progress = 3
    set_shader_param("transition_type", TransitionType.BASIC)
    set_shader_param("position", Vector2(0.5, 0.5))
    set_shader_param("grid_size", Vector2(5.0, 0.0))  #  or (0.0, 5.0)
    set_shader_param("progress_bias", Vector2(5.0, 0.0))  #  or (0.0, 5.0)
