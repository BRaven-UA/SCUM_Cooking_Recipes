extends Control

var _selected_ingredient: Dictionary
onready var line_edit = $LineEdit
onready var found_list = $LineEdit/FoundList
onready var amount_box = $LineEdit/Amount


func _ready() -> void:
	line_edit.connect("text_changed", self, "_on_search_text_changed")
	found_list.connect("item_selected", self, "_on_search_item_selected")
	amount_box.connect("value_changed", self, "_on_amount_value_changed")

func _on_search_text_changed(text: String):
	found_list.clear()
	var index := 0
	if text:
		for id in DB.INGREDIENTS:
			if text.to_lower() in DB.INGREDIENTS[id][DB.NAME].to_lower():
				found_list.add_item(DB.INGREDIENTS[id][DB.NAME], DB.ATLAS)
				found_list.set_item_icon_region(index, DB.get_icon_region(id))
				index += 1
	found_list.sort_items_by_text()
	found_list.visible = index > 0

func _on_search_item_selected(index: int):
	found_list.hide()
	line_edit.text = found_list.get_item_text(index)
	line_edit.caret_position = line_edit.text.length()
	_selected_ingredient = DB.get_data_by_name(line_edit.text)
	amount_box.step = 0.1 if _selected_ingredient[DB.UNIT] == DB.LITERS else 1

func _on_amount_value_changed(amount: float):
	if _selected_ingredient:
		pass
