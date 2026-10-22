// Adds line breaks so text never runs past _width pixels.
// Wrapping BEFORE typing stops words from jumping to the next line mid-word.
// Set the font with draw_set_font before calling this.
function wrap_text(_text, _width) {
	var _words = string_split(_text, " ")
	var _result = ""
	var _line = ""
	for (var i = 0; i < array_length(_words); i++) {
		var _test = _line + " " + _words[i]
		if _line == "" _test = _words[i]

		if string_width(_test) > _width {
			// This word doesn't fit: finish the line and start a new one
			_result += _line + "\n"
			_line = _words[i]
		} else {
			_line = _test
		}
	}
	return _result + _line
}

// ---------- Running the script ----------

// Runs commands until one needs to wait (text, a choice, a wipe...)
function story_run() {
	repeat 1000 {
		if mode != "run" {
			return
		}
		if pos >= array_length(global.script) {
			mode = "end"
			return
		}
		var _c = global.script[pos]
		pos += 1
		do_command(_c)
	}
	show_error("The story jumped 1000 times without showing any text. Look for a jump() that loops forever.", true)
}

// Does one command
function do_command(_c) {
	if _c.type == "say" {
		if _c.flag != undefined {
			check_flag(_c.flag.flag)
			global.flags[$ _c.flag.flag] += _c.flag.amount
		}
		array_push(history, { line: _c, stage: stage_save() })
		back_steps = 0
		show_line(_c, false)
		mode = "text"
	}

	if _c.type == "room" {
		history = []
		var _t = instance_create_depth(0, 0, -1000, oTransition)
		_t.target_room = _c.room
		mode = "wipe"         // oTransition sets mode back to "run" when it's done
	}

	if _c.type == "enter" stage_enter(_c.name, _c.expression)
	if _c.type == "leave" stage_leave(_c.name)
	if _c.type == "leave_all" {
		for (var i = 0; i < array_length(stage); i++) stage[i].leaving = true
	}

	if _c.type == "choice" {
		history = []
		choices = _c.options
		choice_index = 0
		mode = "choice"
	}

	if _c.type == "jump" pos = find_label(_c.go)

	if _c.type == "check" {
		check_flag(_c.flag)
		if global.flags[$ _c.flag] >= _c.atleast {
			pos = find_label(_c.yes)
		} else {
			pos = find_label(_c.no)
		}
	}

	if _c.type == "explore" {
		history = []
		ignore_input = 2
		mode = "explore"
	}

	if _c.type == "wait" {
		pause_timer = _c.time * game_get_speed(gamespeed_fps)
		mode = "pause"
	}

	if _c.type == "shake" {
		shake_timer = shake_time
		shake_amount = _c.strength
	}

	if _c.type == "music" {
		if current_music != noone audio_stop_sound(current_music)
		current_music = noone
		if _c.sound != noone current_music = audio_play_sound(_c.sound, 1, true)
	}

	if _c.type == "sound" audio_play_sound(_c.sound, 1, false)

	if _c.type == "end" game_restart()

	// "label" does nothing. It only marks a spot to jump to.
}

// Finds where a label is in the script
function find_label(_name) {
	for (var i = 0; i < array_length(global.script); i++) {
		var _c = global.script[i]
		if _c.type == "label" and _c.name == _name return i
	}
	show_error("No label called \"" + _name + "\". Check the spelling in scrStory.", true)
}

function check_flag(_name) {
	if !variable_struct_exists(global.flags, _name) {
		show_error("No flag called \"" + _name + "\". Add it to global.flags in scrStory.", true)
	}
}

// Puts a line in the textbox. _instant skips the typing.
function show_line(_c, _instant) {
	speaker = _c.name
	draw_set_font(fnDialogue)
	shown_text = wrap_text(_c.text, box_w - padding * 2)
	chars = 0
	if _instant chars = string_length(shown_text)
	auto_timer = 0

	// The speaker changes expression
	var _a = stage_find(speaker)
	if _a != undefined {
		check_expression(_c.expression)
		_a.expression = _c.expression
	}
}

function check_expression(_name) {
	if !variable_struct_exists(global.expressions, _name) {
		show_error("No expression called \"" + _name + "\". Add it to global.expressions in scrStory.", true)
	}
}

// The player finished reading a line
function story_next() {
	// Reading back through old lines: step forward one
	if back_steps > 0 {
		back_steps -= 1
		var _h = history[array_length(history) - 1 - back_steps]
		stage_load(_h.stage)
		show_line(_h.line, true)
		return
	}
	// A hotspot with nothing in the script: back to exploring
	if back_to_explore {
		back_to_explore = false
		ignore_input = 2
		mode = "explore"
		return
	}
	mode = "run"
}

// The Back button: show the line before this one
function story_back() {
	if back_steps >= array_length(history) - 1 {
		return
	}
	back_steps += 1
	var _h = history[array_length(history) - 1 - back_steps]
	stage_load(_h.stage)
	show_line(_h.line, true)
}

// Called by oHotspot when it's clicked during explore()
function click_hotspot(_name, _hotspot) {
	ignore_input = 2
	for (var i = 0; i < array_length(global.script); i++) {
		var _c = global.script[i]
		if _c.type == "label" and _c.name == _name {
			if _c.once {
				array_push(global.used_clicks, _name)
				instance_destroy(_hotspot)
			}
			pos = i + 1
			mode = "run"
			return
		}
	}
	// Nothing in the script for this hotspot
	show_line(narrate("Nothing interesting."), false)
	back_to_explore = true
	mode = "text"
}

// ---------- The stage (characters on screen) ----------

function stage_find(_name) {
	for (var i = 0; i < array_length(stage); i++) {
		if stage[i].name == _name and !stage[i].leaving return stage[i]
	}
	return undefined
}

function stage_enter(_name, _expression) {
	if !variable_struct_exists(global.characters, _name) {
		show_error("No character called \"" + _name + "\". Add them with character() in scrStory.", true)
	}
	check_expression(_expression)

	// Already here: just change expression
	var _a = stage_find(_name)
	if _a != undefined {
		_a.expression = _expression
		return
	}
	array_push(stage, {
		name: _name,
		sprite: global.characters[$ _name].sprite,
		expression: _expression,
		x: 0,
		target_x: 0,
		alpha: 0,
		lift: 0,
		scale: 1,
		leaving: false
	})
	stage_arrange()
}

function stage_leave(_name) {
	var _a = stage_find(_name)
	if _a == undefined {
		return
	}
	_a.leaving = true
	stage_arrange()
}

// Spreads everyone evenly across the screen
function stage_arrange() {
	var _count = 0
	for (var i = 0; i < array_length(stage); i++) {
		if !stage[i].leaving _count += 1
	}
	var _n = 0
	for (var i = 0; i < array_length(stage); i++) {
		var _a = stage[i]
		if _a.leaving continue
		_n += 1
		_a.target_x = room_width * _n / (_count + 1)
		// Someone brand new appears in their spot instead of sliding in
		if _a.alpha == 0 _a.x = _a.target_x
	}
}

// Saves who is on stage, for the Back button
function stage_save() {
	var _saved = []
	for (var i = 0; i < array_length(stage); i++) {
		if !stage[i].leaving array_push(_saved, { name: stage[i].name, expression: stage[i].expression })
	}
	return _saved
}

// Puts the stage back the way it was saved
function stage_load(_saved) {
	stage = []
	for (var i = 0; i < array_length(_saved); i++) {
		stage_enter(_saved[i].name, _saved[i].expression)
	}
	for (var i = 0; i < array_length(stage); i++) {
		stage[i].alpha = 1
		stage[i].x = stage[i].target_x
	}
}

// Slides, fades, and speaking poses. Runs every frame.
function stage_update() {
	for (var i = array_length(stage) - 1; i >= 0; i--) {
		var _a = stage[i]
		_a.x = lerp(_a.x, _a.target_x, slide_spd)

		if _a.leaving {
			_a.alpha -= fade_spd
			if _a.alpha <= 0 array_delete(stage, i, 1)
		} else {
			_a.alpha = min(1, _a.alpha + fade_spd)
		}

		// The speaker rises a little and grows a little
		var _lift = 0
		var _scale = 1
		if _a.name == speaker and mode == "text" {
			_lift = speak_lift
			_scale = speak_scale
		}
		_a.lift = lerp(_a.lift, _lift, pose_spd)
		_a.scale = lerp(_a.scale, _scale, pose_spd)
	}
}

// Draws one character
function draw_actor(_a, _dx, _dy) {
	var _color = c_white
	if speaker != "" and _a.name != speaker and mode == "text" _color = dim_color
	var _frame = global.expressions[$ _a.expression]
	draw_sprite_ext(_a.sprite, _frame, _a.x + _dx, char_y - _a.lift + _dy, _a.scale, _a.scale, 0, _color, _a.alpha)
}

// Draws one bottom-of-screen button
function draw_story_button(_x, _text, _lit) {
	draw_set_alpha(0.85)
	draw_set_color(c_black)
	if _lit draw_set_color(c_navy)
	draw_rectangle(_x, button_y, _x + button_w, button_y + button_h, false)
	draw_set_alpha(1)
	draw_set_color(c_white)
	draw_rectangle(_x, button_y, _x + button_w, button_y + button_h, true)
	draw_set_halign(fa_center)
	draw_text(_x + button_w / 2, button_y + 2, _text)
	draw_set_halign(fa_left)
}
