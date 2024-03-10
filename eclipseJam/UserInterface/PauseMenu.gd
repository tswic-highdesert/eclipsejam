extends Control


@onready var main = $"../../"


func _on_resume_pressed():
	main.pauseMenu()


func _on_quit_pressed():
	get_tree().quit()


func _on_resume_mouse_entered():
	$MarginContainer/VBoxContainer/ResumeSprite.frame = 5


func _on_resume_mouse_exited():
	$MarginContainer/VBoxContainer/ResumeSprite.frame = 4


func _on_quit_mouse_entered():
	$MarginContainer/VBoxContainer/QuitSprite.frame = 3


func _on_quit_mouse_exited():
	$MarginContainer/VBoxContainer/QuitSprite.frame = 2
