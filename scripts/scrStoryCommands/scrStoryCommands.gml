// Story commands. Each one makes a struct, and oStory reads them in order.
// Writers use these in scrStory. Nobody should need to change this script.

#macro once true      // clicked("desk", once): the hotspot disappears after one use

// Sets up a character: their name, sprite, and name tag color
function character(_name, _sprite, _color) {
	global.characters[$ _name] = { sprite: _sprite, color: _color }
}

// Changes rooms with a black wipe
function goto_room(_room) {
	return { type: "room", room: _room }
}

// Text with no character attached. Can also change a flag.
function narrate(_text, _flag = undefined) {
	return { type: "say", name: "", text: _text, expression: "normal", flag: _flag }
}

// A character talks. The two extras are optional and can go in any order:
// an expression like "happy", and a flag change like add_flag("trust", 1).
// No expression means "normal".
function say(_name, _text, _extra1 = undefined, _extra2 = undefined) {
	var _line = { type: "say", name: _name, text: _text, expression: "normal", flag: undefined }
	var _extras = [_extra1, _extra2]
	for (var i = 0; i < 2; i++) {
		if is_string(_extras[i]) _line.expression = _extras[i]
		if is_struct(_extras[i]) _line.flag = _extras[i]
	}
	return _line
}

// A flag change. It goes inside say() or narrate().
function add_flag(_flag, _amount) {
	return { flag: _flag, amount: _amount }
}

// A character fades in, and everyone slides over to make room
function enter(_name, _expression = "normal") {
	return { type: "enter", name: _name, expression: _expression }
}

// A character fades out
function leave(_name) {
	return { type: "leave", name: _name }
}

// Everyone fades out at the same time
function leave_all() {
	return { type: "leave_all" }
}

// Shows options: choice("Text", "label", "Text", "label", ...)
function choice() {
	var _options = []
	for (var i = 0; i < argument_count; i += 2) {
		array_push(_options, { text: argument[i], go: argument[i + 1] })
	}
	return { type: "choice", options: _options }
}

// A spot in the story that jump(), choice() and if_flag() can go to
function label(_name) {
	return { type: "label", name: _name, once: false }
}

// Where the story goes when a hotspot with click = _name is clicked
function clicked(_name, _once = false) {
	return { type: "label", name: _name, once: _once }
}

// Goes to a label
function jump(_label) {
	return { type: "jump", go: _label }
}

// Goes to _yes if the flag is at least _atleast, otherwise to _no
function if_flag(_flag, _atleast, _yes, _no) {
	return { type: "check", flag: _flag, atleast: _atleast, yes: _yes, no: _no }
}

// Hides the textbox and lets the player click hotspots
function explore() {
	return { type: "explore" }
}

// Pauses the story for some seconds
function wait(_seconds) {
	return { type: "wait", time: _seconds }
}

// Shakes the screen
function shake(_strength = 8) {
	return { type: "shake", strength: _strength }
}

// Plays a song on loop. music(noone) stops it.
function music(_sound) {
	return { type: "music", sound: _sound }
}

// Plays a sound once
function sound(_sound) {
	return { type: "sound", sound: _sound }
}

// The story is over: the next click restarts the game
function end_story() {
	return { type: "end" }
}
