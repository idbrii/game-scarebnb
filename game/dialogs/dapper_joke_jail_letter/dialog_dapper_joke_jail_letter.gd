@tool
extends ScareJokeDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Virtual ░░░░ {{{1

func get_good_item():
    return I.Letter


func play_joke_setup():
    await E.queue([
        "DapperGhost: Thanks for picking me up from jail.",
    ])


func play_bad_joke():
    await E.queue([
        "Player: What? No I didn’t.",
        "DapperGhost: [shake](just go along with it kid)[/shake] Sure ya did. In your car!",
        "Player: I don’t have a car.",
        "DapperGhost: Yeesh. Somebody lock this kid up for gross comedic negligence.",
    ])


func play_good_joke():
    await E.queue([
        "Player: No problem. What were you in for, again?",
        "DapperGhost: Possession.",
        "Player: And why’d they let you out?",
        "DapperGhost: Good boo-haviour.",
        "Player: And why did I pick you up?",
        "DapperGhost: Because I’m your ghoul-friend! Mwah!",
    ])


func play_quit_excuse():
    await C.player.say("I just remembered I left the tap running.")
