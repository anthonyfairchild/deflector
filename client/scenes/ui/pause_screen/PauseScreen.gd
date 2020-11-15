extends Control

signal resume_clicked
signal menu_clicked

func _ready():
	pass # Replace with function body.

func _on_MenuButton_pressed():
	emit_signal("menu_clicked")



func _on_BackButton_pressed():
	emit_signal("resume_clicked")
