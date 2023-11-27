tool
extends TextureProgress

var _data: Dictionary


func _ready() -> void:
	DB.connect("ingredient_changed", self, "_on_ingredient_changed")

func _draw() -> void:
	draw_texture_rect_region(DB.ATLAS, Rect2((rect_size - DB.ICON_SIZE) * 0.5, DB.ICON_SIZE), _data[DB.REGION])

	var progress = "%s/%s%s" % [str(value), str(max_value), " L" if _data.get(DB.UNIT, 0) == DB.LITERS else ""]
	draw_string(DB.DEFAULT_FONT, Vector2(5, 5 + DB.DEFAULT_FONT.get_height() * 0.5), progress)

	var title = _data[DB.NAME]
	draw_string(DB.TINY_FONT, Vector2((rect_size.x - DB.TINY_FONT.get_string_size(title).x) * 0.5, rect_size.y - 5), title)

func activate(data: Dictionary, amount: float):
	_data = data
	max_value = amount
	_data[DB.REGION] = DB.get_icon_region(_data[DB.ICON])
	update()

func update():
	value = min(_data.get(DB.AVAILABLE, 0) - _data.get(DB.USED, 0), max_value)
	if value > 0:
#		_data[DB.USED] = _data.get(DB.USED, 0) + value
		_data[DB.USED] += value
#		tint_progress = Color.yellow if value < max_value else Color.green
		tint_progress = Color.green
	else:
		tint_progress = Color.white
	.update()

func _on_ingredient_changed(ingredient: Dictionary):
	if ingredient == _data:
		update()
