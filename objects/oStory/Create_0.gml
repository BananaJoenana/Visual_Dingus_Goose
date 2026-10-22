// Persistent: carries the story from room to room
global.characters = {}
global.used_clicks = []   // hotspots used up by clicked("...", once)
story_script()

// Where we are
pos = 0               // which command in global.script is next
mode = "run"          // "run", "text", "choice", "explore", "wipe", "pause", "end"
ignore_input = 0      // frames to ignore clicks, so one click can't do two things

// Stage
stage = []            // the characters on screen
char_y = 720          // bottom of the screen, since character origins are Bottom Centre
slide_spd = 0.15      // how fast characters slide to their spot
fade_spd = 0.08       // how fast characters fade in and out
speak_lift = 12       // pixels the speaker rises
speak_scale = 1.05    // how much bigger the speaker gets
pose_spd = 0.2        // how fast the speaker rises and grows
dim_color = make_color_rgb(150, 150, 160)   // tint for characters who aren't talking

// Textbox layout (screen pixels)
box_x = 40
box_y = 470
box_w = 1200
box_h = 200
padding = 28          // the invisible inner border: text wraps before it
name_x = 60
name_y = 432

// Typewriter
type_spd = 0.6        // characters per frame
chars = 0
shown_text = ""
speaker = ""

// Auto
auto_on = false
auto_timer = 0
auto_delay = 60       // frames to wait after a line finishes
auto_per_char = 2     // extra frames per character, so long lines stay up longer

// Back
history = []          // lines read since the last choice, room change or explore
back_steps = 0        // how far back the player is reading
back_to_explore = false

// Choices
choices = []
choice_index = 0
choice_gap = 44       // pixels between choice lines

// Buttons (screen pixels)
button_y = 682
button_w = 100
button_h = 30
back_x = 1020
auto_x = 1140

// Effects
pause_timer = 0
shake_timer = 0
shake_time = 20       // frames a shake lasts
shake_amount = 0
current_music = noone
