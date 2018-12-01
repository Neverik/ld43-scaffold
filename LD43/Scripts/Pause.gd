extends ColorRect

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		if !get_tree().paused:
			get_tree().paused =  true
			show()
		else:
			unpause()

func unpause():
	get_tree().paused = false
	hide()

func reload():
	unpause()
	Manager.goto_scene("res://Scenes/Game.tscn")


func menu():
	unpause()
	Manager.goto_scene("res://Scenes/Menu.tscn")

var muted = false

func mute():
	muted = not muted
	$Button4.text = ["Mute", "Unmute"][int(muted)]
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), muted)
