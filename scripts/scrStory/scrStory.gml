// The whole story lives here. Writers only edit this script.
function story_script() {

	// Characters: name, sprite, name tag color
	character("Christian", sChristian, c_black)
	character("Emerson", sEmerson, c_orange)
	character("ChatGPT", sChatGPT, c_teal)

	// Expressions: which frame of a character sprite each one shows.
	// "normal" is used when a line doesn't name one.
	// ADD HERE: a new expression, then draw that frame in every character sprite
	global.expressions = {
		normal: 0,
		happy: 1,
		angry: 2,
		sad: 3
	}

	// Flags: every flag the story uses, starting at 0
	global.flags = {
		trust: 0,
		has_key: 0
	}

	// The story, top to bottom
	global.script = [
		goto_room(rmHallway),
		// music(sndHallway),   <- once you add a song
		narrate("I need to find my way home, from this place, this hell called mexico."),
		enter("Emerson"),
		say("Emerson", "Hey Christian, its me Emerson. I've come to help you escape and get your dumb straw hat.", "angry"),
		say("Emerson", "We've been trying to contact you about mousetrap, and the whereabouts of demond."),
		enter("ChatGPT", "angry"),
		say("ChatGPT", "There you are."),
		shake(),
		say("ChatGPT", "buy my subscription, now!", "angry"),
		leave("ChatGPT"),
		say("Emerson", "Who was that?", "sad"),
		choice(
			"i dont know", "i forgot to renew my open ai subscription",
			"dont even", "i forgot to renew my open ai subscription"
		),

		label("dont even"),
		say("Emerson", "okay fine, but do you remember she hulk?", "happy", add_flag("trust", 1)),
		jump("office"),

		label("i forgot to renew my open ai subscription"),
		say("Emerson", "you aren't even smart enough to use open ai in the first place", "angry", add_flag("trust", -1)),

		label("office"),
		leave_all(),
		goto_room(rmOffice),
		narrate("The office is empty. Maybe there's something useful in here."),
		explore(),

		// Hotspots: clicking one with click = "desk" comes here
		clicked("desk", once),
		narrate("A small key is taped under the desk.", add_flag("has_key", 1)),
		explore(),

		clicked("door"),
		if_flag("has_key", 1, "door_open", "door_locked"),

		label("door_locked"),
		narrate("It's locked."),
		explore(),

		label("door_open"),
		narrate("The key turns. Someone is waiting on the other side."),
		wait(1),
		if_flag("trust", 1, "good_end", "bad_end"),

		label("good_end"),
		enter("Christian", "happy"),
		say("Christian", "I knew I could find that god forsaken hat.", "happy"),
		narrate("THE END"),
		end_story(),

		label("bad_end"),
		enter("ChatGPT", "angry"),
		say("Principal", "And just where do you think you're going?", "angry"),
		narrate("THE END"),
		end_story()
	]
}
