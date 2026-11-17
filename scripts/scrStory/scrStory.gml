// The whole story lives here. Writers only edit this script.
function story_script() {

	// Characters: name, sprite, name tag color
	character("Christian", sChristian, c_black)
	character("Emerson", sEmerson, c_orange)
	character("ChatGPT", sChatGPT, c_teal)
	character("TJ", sTJ_Phone_Call, c_green)
	character("Mr. Buck", sMrBuck, c_fuchsia)
	character("kwebbelslop", sKwebbel, c_yellow)
	character("Evan", sEvanS, c_lime)
	
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
		narrate("I...how did I lose my way? It...when did this happen?"),
		enter("Emerson"),
		say("Emerson", "Hey Christian, its me Emerson. I've come to help you escape and get your dumb straw hat.", "angry"),
		say("Emerson", "I've been trying to reach you, but you've been out of the country for a while, and due to uhnforseen circumstances weve encountered technological difficulties."),
		leave("Emerson"),
		enter("Christian", "angry"),
		say("Christian", "I didn't even know you'd make an actual effort to come and try to reach me, but you always prevail, Emerson."),
		leave("Christian"),
		enter("TJ"),
		say("TJ", "Who is this? Oh right, Christian and Emerson, no?"),
		leave("TJ"),
		enter("Christian", "angry"),
		say("Christian", "Yeah"),
		leave("Christian"),
		enter("Emerson"),
		say("Emerson", "yeah, we ran into a bit of an issue though."),
		say("TJ", "Right...you can't exactly get back cause your poor, let me work my amazing hackerman skills."),
		say("TJ", "There, I arranged for you to get a car. It should be availible for you to travel with now."),
		leave("Emerson"),
		leave("Christian"),
		leave("TJ"),
		goto_room(rmBlandHighway), 
		enter("Christian"),
		say("Christian", "Thanks to TJ's efforts' were finally going. About time."),
		leave("Christian"),
		enter("Emerson"),
		say("Emerson", "Sounds good to me, when will you be near the United States?"),
		leave("Emerson"),
		enter("TJ"),
		say("TJ", "Beware, as there have been reports of this highway or road being dangerous, be sure to keep a watchful eye on the road, big C. You'll need it."),
		leave("TJ"),
		enter("Christian"),
		say("Christian", "Aight, say less, we gon be in Texas in no time, don't even worry."),
		leave("Christian"),
		enter("TJ"),
		say("TJ", "Also, I forwarded you the address to Emerson's workplace, you should be able to meetup with him here."),
		leave("Christian"),
		leave("TJ"),
		leave("Emerson"),
		goto_room(rmTomThumb),
		narrate("I...think this is it, no? This is where we were supposed to meet, right?"),
		enter("Emerson"),
		say("Emerson", "Alright, what's up?"),
		leave("Emerson"),
		enter("Christian"),
		say("Christian", "yeah, we ran into a bit of an issue though."),
		enter("Christian"),
		leave("Christian"),
		enter("Emerson"),
		say("Emerson", "and that would be?"),
		leave("Emerson"),
		enter("Christian"),
		say("Christian", "I'm poor."),
		say("Christian", "But, I have an Idea...it might work"),
		leave("Christian"),
		enter("Emerson"),
		say("Emerson", "And that would be?"),
		leave("Emerson"),
		enter("Christian"),
		say("Christian", "Let me make a phone call, I know exactly who to talk to."),
		leave("Christian"),
		narrate("you call mr. buck to help you out financially"),
		enter("Mr. Buck"),
		say("Mr. Buck", "You want money?"),
		leave("Mr. Buck"),
		enter("Christian"),
		say("Christian", "yeah, do you know what I gotta do for it?"),
		leave("Christian"),
		enter("Mr. Buck"),
		say("Mr. Buck", "yeah just answer me this one question"),
		leave("Mr. Buck"),
		enter("TJ"),
		say("TJ", "will he preform when he has money right infront of him"),
		leave("TJ"),
		enter("Mr. Buck"),
		say("Mr. Buck", "What's the best halo?"),
		leave("Mr. Buck"),
		enter("Christian"),
		say("Christian", "Halo 3"),	
		leave("Christian"),
		say("Mr. Buck", "your right"),
		say("Mr. Buck", "take this money to pay for your goods."),
		narrate("you take the money and decide that you are gonna pay today instead of just taking it"),
		leave("Mr. Buck"),
		enter("Christian"),
		say("Christian", "Alright, I've gotten the money necessary to make the purchase."),
		leave("Christian"),
		enter("Emerson"),
		say("Emerson", "Sounds good, let me ring ya up."),
		narrate("you pay using the money from mr beast"),
		leave("Emerson"),
		enter("Christian"),
		say("Christian", "Thanks emerson, really helped me out here with all that."),
		leave("Christian"),
		enter("Emerson"),
		say("Emerson", "yeah, no problem man!"),
		leave("Christian"),
		say("Christian", "who is that in the parking lot...what the..?"),
		leave("Christian"),
		enter("kwebbelslop"),
		say("kwebbelslop", "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),
		leave("kwebbelslop"),
		enter("Christian"),
		say("Christian", "I-I'm gonna ignore that.."),
		leave("Christian"),
		enter("TJ"),
		say("TJ", "Yeah, please do. That's kwebbelkop, or as I call him, kwebbelslop. You can blame caius for his existence, speaking of which, do you know where he is?"),
		leave("TJ"),
		enter("Christian"),
		say("Christian", "No, I unfortunately don't know where caius is, the main part is getting home. Though, I can't believe the people we encountered today."),
		say("Christian", "Well, last stop, home I guess."),
		// insert road above this line
		say("Christian", "Gosh, what a journey, let me make a call to somebody."),
		leave("Christian"),
		enter("TJ"),
		say("TJ", "You called?"),
		leave("TJ"),
		enter("Christian"),
		say("Christian", "Yeah, whats up man."),
		leave("Christian"),
		enter("TJ"),
		say("TJ", "Nothin' just making sure my right hand man gets home safely. Also, your house should be coming up veryy soon if I recall correctly."),
		leave("TJ"),
		enter("Christian"),
		say("Christian", "Thanks for the navigation home, and for the journey that this has taken us on."),
		say("Christian", "didn't think i would make it home, without yall's help I wouldn't be here right now."),
		leave("Christian"),
		enter("TJ"),
		say("TJ", "Yo, why is he on the road?"),
		say("TJ", "is that the crazy guy from the parking lot?"),
		leave("TJ"),
		enter("Christian"),
		say("Christian", "yeah...unfortunately."),
		leave("Christian"),
		enter("TJ"),
		say("TJ", "What I want you to do...is to go around him. DO. NOT. LOOK."),
		leave("TJ"),
		enter("Christian"),
		say("Christian", "uhhh, why?"),
		say("Christian", "He will scream-"),
		leave("Christian"),
		enter("kwebbelslop"),
		say("kwebbelslop", "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),
		leave("kwebbelslop"),
		enter("TJ"),
		say("TJ", "*sigh*"),
		say("TJ", "What did I say?"),
		leave("TJ"),
		enter("Christian"),
		say("Christian", "Right, let me deal with this properly."),
		say("Christian", "go away bro please"),
		leave("Christian"),
		enter("kwebbelslop"),
		say("kwebbelslop", "NOUUUUUUUUUUUUUUUUUUUUUUUUHHHHHHHHHHHHHHHHHHHHHH"),
		say("kwebbelslop", "AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHWAHAHAHAHAHA"),
		leave("kwebbelslop"),
		enter("Christian"),
		say("Christian", "you know what, watch this"),
		narrate("you get out the car and give kwebbeslop a haymaker, causing him to instantly cease to exist"),
		say("Christian", "with THAT issue out the way, we can finally continue on with our journey."),
		leave("Christian"),
		enter("TJ"),
		say("TJ", "Christian..."),
		leave("TJ"),
		enter("Christian"),
		say("Christian", "yeah?"),
		leave("Christian"),
		enter("TJ"),
		say("TJ", "Did you just..."),
		leave("TJ"),
		enter("Christian"),
		say("Christian", "Did I just what"),	
		leave("Christian"),
		enter("TJ"),
		say("TJ", "Did you just kill kwebbelslop?"),		
		leave("TJ"),
		enter("Christian"),
		say("Christian", "Yeah, I did, why?"),
		say("Christian", "What else was I supposed to do?"),
		leave("Christian"),
		enter("TJ"),
		say("TJ", "I don't know?! Knock him out?! Not kill him?!"),
		leave("TJ"),
		enter("Christian"),
		say("Christian", "does it really matter, though?"),	
		leave("Christian"),
		enter("TJ"),
		say("TJ", "Yes. It does matter. You just committed murder."),
		enter("TJ"),
		say("TJ", "Although, he was annoying, I got you covered. An incident response team has been sent to cover your tracks."),
		say("Christian", "Thanks mate."),
		say("TJ", "Yeah your welcome."),
		say("Christian", "Now Evan's callin me about this computer and whatnot.."),	
		say("Evan", "YOU MESSED wITH MY COMPUteR YOU WORM!"),		
		say("Christian", "NO???"),	
		
















		
		say("Emerson", "Hey man, it's time to pay, I see you've bought some water and some other necessities."), 
		say("Christian", "With what money?", "angry"),
		leave("ChatGPT"),
		say("Emerson", "You have to pay.", "sad"),
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
