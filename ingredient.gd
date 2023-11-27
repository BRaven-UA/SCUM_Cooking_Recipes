tool
extends TextureProgress

#const a := {"Water": "s", "Steak": "d", "Cabbage": "e"}

#export (String, a) var test setget test
#func test(_value):
#	test = _value
export (DB.ID) var id setget set_id
#export (Texture) var icon setget set_icon
#export (String) var title setget set_title # 'name' already exists
export (float) var amount setget set_amount


func set_id(_value: int):
	id = _value
#	set_title(DB.INGREDIENTS[id][DB.NAME])
#	self.title = DB.INGREDIENTS[id][DB.NAME]
	update()

#func set_icon(texture: Texture):
#	icon = texture
#	update()

#func set_title(_value: String):
#	print(_value)
#	title = _value
#	update()

func set_amount(_value: float):
	amount = _value
	max_value = amount
	update()

func _draw() -> void:
#	if icon:
#		draw_texture(icon, (rect_size - icon.get_size()) / 2.0)
	draw_texture_rect_region(DB.ATLAS, Rect2((rect_size - DB.ICON_SIZE) * 0.5, DB.ICON_SIZE), DB.get_icon_region(id))
	
	value = DB.INGREDIENTS[id].get(DB.USED, 0)
	if value > 0:
		DB.INGREDIENTS[id][DB.USED] -= min(value, amount)
	tint_progress = Color.yellow if value < max_value else Color.green
	var progress = "%s/%s%s" % [str(value), str(max_value), " L" if DB.INGREDIENTS[id].get(DB.UNIT, 0) == DB.LITERS else ""]
#	draw_string(DB.DEFAULT_FONT, (rect_size - Vector2(DB.DEFAULT_FONT.get_string_size(progress).x, DB.DEFAULT_FONT.get_descent() - DB.DEFAULT_FONT.get_height())) * 0.5, progress)
	draw_string(DB.DEFAULT_FONT, Vector2(5, 5 + DB.DEFAULT_FONT.get_height() * 0.5), progress)
	
	var title = DB.INGREDIENTS[id][DB.NAME]
	draw_string(DB.TINY_FONT, Vector2((rect_size.x - DB.TINY_FONT.get_string_size(title).x) * 0.5, rect_size.y - 5), title) 
