extends Control

export(PackedScene) var title_screen_scene
export(PackedScene) var game_screen_scene
export(PackedScene) var pause_screen_scene
export(PackedScene) var countdown_screen_scene
export(PackedScene) var about_screen_scene

var _title_screen
var _game_screen
var _pause_screen
var _about_screen

func _ready():
	_show_title_screen()
	
func _show_title_screen():
	_title_screen = title_screen_scene.instance()
	_title_screen.connect("one_player_selected", self, "_title_screen_one_player_selected")
	_title_screen.connect("two_player_selected", self, "_title_screen_two_player_selected")
	_title_screen.connect("online_selected", self, "_title_screen_online_selected")
	_title_screen.connect("settings_selected", self, "_title_screen_settings_selected")
	_title_screen.connect("about_selected", self, "_title_screen_about_selected")
	add_child(_title_screen)

func _title_screen_one_player_selected():
	_start_game()
	
func _start_game():
	_title_screen.queue_free()
	_title_screen = null
	
	var countdown_screen = countdown_screen_scene.instance()
	add_child(countdown_screen)
	
	_game_screen = game_screen_scene.instance()
	_game_screen.connect("game_over", self, "_game_screen_game_over")
	_game_screen.connect("game_paused", self, "_game_screen_game_paused")
	add_child(_game_screen)

	get_tree().paused = true
	yield(countdown_screen, "finished")
	countdown_screen.queue_free()
	get_tree().paused = false
	_game_screen.start_game()

func _title_screen_two_player_selected():
	pass

func _title_screen_online_selected():
	pass

func _title_screen_settings_selected():
	pass

func _title_screen_about_selected():
	_title_screen.queue_free()
	_title_screen = null
	_about_screen = about_screen_scene.instance()
	_about_screen.connect("back_pressed", self, "_about_screen_back_pressed")
	add_child(_about_screen)

func _about_screen_back_pressed():
	_about_screen.queue_free()
	_about_screen = null
	_show_title_screen()

func _game_screen_game_over(winning_ship):
	pass
	
func _game_screen_game_paused():
	if _pause_screen:
		return
		
	get_tree().paused = true
	_pause_screen = pause_screen_scene.instance()
	_pause_screen.connect("resume_clicked", self, "_pause_menu_resume_clicked")
	_pause_screen.connect("menu_clicked", self, "_pause_menu_menu_clicked")
	add_child(_pause_screen)

func _pause_menu_resume_clicked():
	get_tree().paused = false
	_pause_screen.queue_free()
	_pause_screen = null
	
func _pause_menu_menu_clicked():
	get_tree().paused = false
	_pause_screen.queue_free()
	_game_screen.queue_free()
	_show_title_screen()
