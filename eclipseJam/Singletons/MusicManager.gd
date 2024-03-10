extends Node

var current_song = ""

func play_song(song_name):
	if song_name != current_song:
		var cur_song_node = get_node_or_null(current_song)
		var new_song_node = get_node(song_name)
		fadein(new_song_node)  # Start the new song
		new_song_node.play()
		current_song = song_name  # Update the current song variable
		
		if cur_song_node:
			fadeout(cur_song_node)

func fadeout(node):
	var default_vol = node.volume_db
	var tween = create_tween()
	tween.tween_property(node, "volume_db", -80, 1)
	await tween.finished
	node.stop()
	node.volume_db = default_vol

func fadein(node):
	var default_vol = node.volume_db
	node.volume_db = -80
	var tween = create_tween()
	tween.tween_property(node, "volume_db", default_vol, 1)
	await tween.finished
	node.volume_db = default_vol
