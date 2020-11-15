extends Control

signal back_pressed

func _ready():
	$Music.play()


func _on_BackButton_pressed():
	emit_signal("back_pressed")

func _on_VisagerLinkButton_pressed():
	OS.shell_open("https://freemusicarchive.org/music/Visager")
