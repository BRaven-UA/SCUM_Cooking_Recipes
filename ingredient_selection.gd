extends TextureRect

signal filter_changed(text)

var ingredient: Dictionary
onready var _name_edit = $Name
onready var _amount_edit = $Amount


func _ready() -> void:
	_name_edit.connect("text_changed", self, "_on_name_changed")
	_amount_edit.connect("value_changed", self, "_on_amount_changed")

func _draw() -> void:
	if ingredient:
		draw_texture_rect_region(DB.ATLAS, Rect2((rect_size - DB.ICON_SIZE) * 0.5, DB.ICON_SIZE), ingredient[DB.REGION])

func set_ingredient(data: Dictionary):
	if data.empty():
		_amount_edit.value = 0
		_amount_edit.hide()
	else:
		_amount_edit.show()
		_name_edit.text = data[DB.NAME]
		_name_edit.caret_position = _name_edit.text.length()
		_amount_edit.suffix = "L" if data.get(DB.UNIT, DB.PIECES) == DB.LITERS else ""
		_amount_edit.step = 0.1 if data.get(DB.UNIT, DB.PIECES) == DB.LITERS else 1.0
		_amount_edit.value = 1
	ingredient = data
	update()
	_name_edit.release_focus()

func _on_name_changed(text: String):
	if visible:
		emit_signal("filter_changed", text)

func _on_amount_changed(amount: float):
	if ingredient:
		ingredient[DB.AVAILABLE] = amount
		ingredient[DB.USED] = 0.0
		DB.emit_signal("ingredient_changed", ingredient)
