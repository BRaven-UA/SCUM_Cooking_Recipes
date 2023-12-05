extends Control

var _ids: Array


func _draw() -> void:
	var text = ""
	for id in _ids:
		var region = DB.get_icon_region(112 + id * 2)
		region.size *= 2
		draw_texture_rect_region(DB.ATLAS, Rect2((rect_size - DB.ICON_SIZE * 2) * 0.5, DB.ICON_SIZE * 2), region)
		
		if text:
			text += " / "
		text += DB.UTILITY_NAMES[id]
	draw_string(DB.DEFAULT_FONT, Vector2((rect_size.x - DB.DEFAULT_FONT.get_string_size(text).x) * 0.5, rect_size.y - 5), text)

func activate(ids: Array):
	_ids = ids
	update()
