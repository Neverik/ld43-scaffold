extends ColorRect
onready var initial = $Bar.rect_scale.x

func set_progress(n):
	$Bar.rect_scale.x = initial * n
