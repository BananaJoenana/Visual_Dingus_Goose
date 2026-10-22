stage_update()

// Screen shake
if shake_timer > 0 {
	shake_timer -= 1
	layer_x("Background", random_range(-shake_amount, shake_amount))
	layer_y("Background", random_range(-shake_amount, shake_amount))
} else {
	layer_x("Background", 0)
	layer_y("Background", 0)
}

if ignore_input > 0 ignore_input -= 1

// Run the script until something needs to wait
if mode == "run" story_run()

// wait()
if mode == "pause" {
	pause_timer -= 1
	if pause_timer <= 0 mode = "run"
	exit
}

if mode != "text" and mode != "choice" exit

// Buttons
var _mx = device_mouse_x_to_gui(0)
var _my = device_mouse_y_to_gui(0)
var _click = mouse_check_button_pressed(mb_left)
var _on_back = _mx > back_x and _mx < back_x + button_w and _my > button_y and _my < button_y + button_h
var _on_auto = _mx > auto_x and _mx < auto_x + button_w and _my > button_y and _my < button_y + button_h
if _click and (_on_back or _on_auto) {
	if _on_auto auto_on = !auto_on
	if _on_back and mode == "text" story_back()
	exit
}

var _advance = ignore_input <= 0 and (keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter) or _click)

// Choices: W/S or the mouse to pick, Space, Enter or click to choose
if mode == "choice" {
	choice_index += keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"))
	if _mx > box_x and _mx < box_x + box_w {
		var _hover = floor((_my - box_y - padding) / choice_gap)
		if _hover >= 0 and _hover < array_length(choices) choice_index = _hover
	}
	choice_index = clamp(choice_index, 0, array_length(choices) - 1)
	if _advance {
		pos = find_label(choices[choice_index].go)
		ignore_input = 2
		mode = "run"
	}
	exit
}

// Text: type it out, then wait for a press (or auto)
if chars < string_length(shown_text) {
	chars += type_spd
	if _advance chars = string_length(shown_text)
} else {
	if auto_on auto_timer += 1
	var _auto_ready = auto_on and auto_timer >= auto_delay + string_length(shown_text) * auto_per_char
	if _advance or _auto_ready story_next()
}
