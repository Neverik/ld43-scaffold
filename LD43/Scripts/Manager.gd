extends Node

# Is this state management?
var state = {}

# Scene loading
onready var root = get_tree().get_root()
onready var current_scene = root.get_child(root.get_child_count() -1)

func load_game():
	goto_scene("res://Scenes/Game.tscn")

func goto_scene(path):
    call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
    current_scene.free()
    var s = ResourceLoader.load(path)
    current_scene = s.instance()
    get_tree().get_root().add_child(current_scene)
    get_tree().set_current_scene(current_scene)

func die():
	goto_scene("res://Scenes/Gameover.tscn")
