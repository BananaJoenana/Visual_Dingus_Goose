draw_set_font(fnDialogue)

// Exploring: a hint instead of the textbox
if mode == "explore" {
	draw_set_color(c_white)
	draw_text(box_x, button_y, "Click around to look at things.")
	exit
}

if mode != "text" and mode != "choice" exit

// Box
draw_set_alpha(0.85)
draw_set_color(c_black)
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false)
draw_set_alpha(1)
draw_set_color(c_white)
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, true)

// Choices
if mode == "choice" {
	for (var i = 0; i < array_length(choices); i++) {
		var _arrow = "   "
		if i == choice_index _arrow = ">  "
		draw_text(box_x + padding, box_y + padding + i * choice_gap, _arrow + choices[i].text)
	}
} else {
	// Name tag, in the character's color
	if speaker != "" {
		draw_set_color(c_white)
		if variable_struct_exists(global.characters, speaker) draw_set_color(global.characters[$ speaker].color)
		draw_text(name_x, name_y, speaker)
		draw_set_color(c_white)
	}

	// Text, typed out
	draw_text(box_x + padding, box_y + padding, string_copy(shown_text, 1, floor(chars)))

	// "Press to continue" arrow once the line is done
	if chars >= string_length(shown_text) {
		draw_text(box_x + box_w - padding - 16, box_y + box_h - padding - 24, ">")
	}
}

// Buttons
draw_story_button(back_x, "Back", false)
draw_story_button(auto_x, "Auto", auto_on)
