extends Control

signal one_player_selected
signal two_player_selected
signal online_selected
signal settings_selected
signal about_selected

onready var music = $Music
onready var menu_select_sound = $MenuSelect
onready var one_player_button = $CenterContainer/VBoxContainer/CenterContainer/MarginContainer/VBoxContainer/OnePlayerButton

var first_focus = false #true # don't play sound on first button focus

func _ready():
	music.play()
	#one_player_button.grab_focus()

func _on_OnePlayerButton_pressed():
	emit_signal("one_player_selected")

func _on_TwoPlayerButton_pressed():
	emit_signal("two_player_selected")

func _on_OnlineTextureButton_pressed():
	emit_signal("online_selected")

func _on_SettingsButton_pressed():
	emit_signal("settings_selected")

func _on_AboutButton_pressed():
	emit_signal("about_selected")

func _button_focused():
	if !first_focus:
		menu_select_sound.play()
	first_focus = false
	
func _on_OnePlayerButton_focus_entered():
	_button_focused()

func _on_TwoPlayerButton_focus_entered():
	_button_focused()

func _on_OnlineTextureButton_focus_entered():
	_button_focused()

func _on_SettingsButton_focus_entered():
	_button_focused()

func _on_AboutButton_focus_entered():
	_button_focused()


func _on_OnePlayerButton_mouse_entered():
	_button_focused()


func _on_TwoPlayerButton_mouse_entered():
	_button_focused()


func _on_OnlineTextureButton_mouse_entered():
	_button_focused()


func _on_SettingsButton_mouse_entered():
	_button_focused()


func _on_AboutButton_mouse_entered():
	_button_focused()
