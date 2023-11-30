extends TextureRect

signal search_string(text)

var ingredient: Dictionary
onready var _name_edit = $Name
onready var _amount_edit = $Amount
onready var _amount_line_edit = _amount_edit.get_line_edit()


func _ready() -> void:
	_name_edit.connect("text_changed", self, "_on_name_changed")
	_amount_edit.connect("value_changed", self, "_on_amount_changed")
#	_amount_line_edit.set("custom_fonts/font", DB.TINY_FONT)
#	DB.connect("ingredient_changed", self, "_on_ingredient_changed")

func _draw() -> void:
	if ingredient:
		draw_texture_rect_region(DB.ATLAS, Rect2((rect_size - DB.ICON_SIZE) * 0.5, DB.ICON_SIZE), ingredient[DB.REGION])

func set_ingredient(data: Dictionary):
	if data.empty():
		_amount_edit.value = 0
		_amount_edit.hide()
		_name_edit.set("custom_fonts/font", DB.DEFAULT_FONT)
		ingredient = data # assign new link after applying changes to the old ingredient
	else:
		ingredient = data # assing new ling before applying changes
		if DB.DEFAULT_FONT.get_string_size(data[DB.NAME]).x > _name_edit.rect_size.x:
			_name_edit.set("custom_fonts/font", DB.TINY_FONT)
		_name_edit.text = data[DB.NAME]
		_name_edit.caret_position = _name_edit.text.length()
		_amount_edit.suffix = "L" if data.get(DB.UNIT, DB.PIECES) == DB.LITERS else ""
		_amount_edit.step = 0.1 if data.get(DB.UNIT, DB.PIECES) == DB.LITERS else 1.0
		_amount_edit.value = 1
		_amount_edit.show()
	update()
	_name_edit.release_focus()

func _on_name_changed(text: String):
	if visible:
		emit_signal("search_string", text)

func _on_amount_changed(amount: float):
	_amount_line_edit.release_focus()
	if ingredient:
		ingredient[DB.AVAILABLE] = amount
		ingredient[DB.USED] = 0.0
		DB.emit_signal("ingredient_changed", ingredient)

#func _on_ingredient_changed(_ingredient: Dictionary):
#	if _ingredient == ingredient:
#		if ingredient[DB.USED] > 0:
#			_amount_line_edit.text = "%d (-%s)" % [_amount_edit.value, str(ingredient[DB.USED])]
