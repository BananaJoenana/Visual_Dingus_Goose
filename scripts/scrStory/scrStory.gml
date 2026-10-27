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
		say("Emerson", "I've been trying to reach you, but you've been out of the country for a while."),
		enter("Christian", "angry"),
		say("Christian", "Oh really?"),
		shake(),
		say("Christian", "Well, could you help me?", "angry"),
		leave("ChatGPT"),
		say("Emerson", "Yeah but at a cost, pay me in USD. The currency you have right now isn't well, USD.", "sad"),
		choice(
			"i dont know", "i forgot to renew my open ai subscription",
			"dont even", "i forgot to renew my open ai subscription"
		),

		label("dont even"),
		say("Emerson", "okay.", "happy", add_flag("trust", 1)),
		jump("office"),

		label("i forgot to renew my open ai subscription"),
		say("Emerson", "...", "angry", add_flag("trust", -1)),

		label("office"),
		leave_all(),
		goto_room(rmOffice),
		narrate("Where is my house, I should look around somewhere.."),
		explore(),

		// Hotspots: clicking one with click = "desk" comes here
		clicked("desk", once),
		narrate("Is that my house?.", add_flag("has_key", 1)),
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
		say("ChatGPT", "And just where do you think you're going?", "angry"),
		narrate("THE END"),
		end_story()
	]
}
