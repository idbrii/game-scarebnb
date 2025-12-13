@tool
extends ScareJokeDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

func get_good_item():
    return I.License


func play_joke_setup():
    await E.queue([
        "DapperGhost: Say, do you know how I died?",
    ])


func play_bad_joke():
    await E.queue([
        "Player: Oh, heavens no. I’d never ask that.",
        "DapperGhost: I… Well, I know how this JOKE died.",
    ])


func play_good_joke():
    await E.queue([
        "Player: Oh, a terrible car accident.",
        "DapperGhost: Really? But I’m a perfect driver!",
        "Player: So perfect you thought you didn’t need your [shake]SHEET BELT![/shake]",
    ])


func play_quit_excuse():
    await C.player.say("I just remembered I left the tap running.")
