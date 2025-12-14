@tool
extends ScareJokeDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

func get_goodbad_options():
    return {
        GOOD = "Yes. You [i]have[/i] been going through some things lately…",
        BAD = "No. Just checking.",
    }


func get_good_item():
    return I.Sketch


func play_joke_setup():
    await E.queue([
        "DapperGhost: Oof.",
        "Player: Are you doing okay?",
        "DapperGhost: What–do I seem [i]depressed[/i] to you?",
    ])


func play_bad_joke():
    await E.queue([
        "Player: No, just checking in per my duties at the B&B.",
        "DapperGhost: You are duller than a doornail with no life experiences.",
    ])


func play_good_joke():
    await E.queue([
        "Player: Well, you [i]have[/i] been going through some things lately…",
    ])


func play_quit_excuse():
    await C.player.say("I just remembered I left the tap running.")
