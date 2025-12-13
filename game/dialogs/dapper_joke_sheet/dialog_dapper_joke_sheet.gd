@tool
extends ScareJokeDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

func get_good_item():
    return I.Sheet


func play_joke_setup():
    await E.queue([
        "DapperGhost: Should I start exor-cising?",
    ])


func play_bad_joke():
    await E.queue([
        "Player: Yes, exercise is good for overall health.",
        "DapperGhost: (sigh) And I’ll exercise my right to kick you outta my room!",
    ])


func play_good_joke():
    await E.queue([
        "Player: Now why would you say a thing like that?",
        "DapperGhost: I recently went from a queen to a king-sized sheet!",
    ])


func play_quit_excuse():
    await C.player.say("Is that the front desk phone ringing?")
    await C.DapperGhost.say("I don't hear anything.")
    await C.player.say("Bye!")
