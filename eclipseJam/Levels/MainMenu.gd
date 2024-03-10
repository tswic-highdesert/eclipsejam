extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/Arena.tscn")
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_play_mouse_entered():
	$MarginContainer/VBoxContainer/PlaySprite.frame = 1
	
func _on_play_mouse_exited():
	$MarginContainer/VBoxContainer/PlaySprite.frame = 0
	



func _on_credits_mouse_entered():
	$MarginContainer/VBoxContainer/CreditsSprite.frame = 7
	

func _on_credits_mouse_exited():
	$MarginContainer/VBoxContainer/CreditsSprite.frame = 6
	



func _on_exit_mouse_entered():
	$MarginContainer/VBoxContainer/ExitSprite.frame = 3
	
func _on_exit_mouse_exited():
	$MarginContainer/VBoxContainer/ExitSprite.frame = 2
