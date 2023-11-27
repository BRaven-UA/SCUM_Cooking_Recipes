extends Control

signal filter_changed(ingredients)

const RECIPE_TEMPLATE := preload("res://recipe.tscn")

var _ingredients: Array
var _selected_ingredient: Dictionary
onready var _line_edit = $LineEdit
onready var _found_list = $LineEdit/FoundList
onready var _amount_box = $LineEdit/Amount
onready var _container = $ScrollContainer/Recipes


func _ready() -> void:
	_line_edit.connect("text_changed", self, "_on_search_text_changed")
	_found_list.connect("item_selected", self, "_on_search_item_selected")
	_amount_box.connect("value_changed", self, "_on_amount_value_changed")
	
	for data in DB.RECIPES:
		var recipe = RECIPE_TEMPLATE.instance()
		_container.add_child(recipe, true)
		recipe.activate(data)
		connect("filter_changed", recipe, "_on_main_filter_changed")
		
		for ingredient in data[DB.INGREDIENTS]:
			if not _ingredients.has(ingredient):
				_ingredients.append(ingredient)

func _on_search_text_changed(text: String):
	_found_list.clear()
	var list_index := 0
	if text:
		var lower_text = text.to_lower()
		for ingredient in _ingredients:
			if lower_text in ingredient[DB.NAME].to_lower():
				_found_list.add_item(ingredient[DB.NAME], DB.ATLAS)
				_found_list.set_item_icon_region(list_index, ingredient[DB.REGION])
				_found_list.set_item_metadata(list_index, ingredient)
				list_index += 1
	_found_list.sort_items_by_text()
	_found_list.visible = list_index > 0

func _on_search_item_selected(index: int):
	_found_list.hide()
	_line_edit.text = _found_list.get_item_text(index)
	_line_edit.caret_position = _line_edit.text.length()
	_selected_ingredient = _found_list.get_item_metadata(index)
	_amount_box.step = 0.1 if _selected_ingredient.get(DB.UNIT, DB.PIECES) == DB.LITERS else 1.0
	_amount_box.value = 1

func _on_amount_value_changed(amount: float):
	if _selected_ingredient:
		_selected_ingredient[DB.AVAILABLE] = amount
		_selected_ingredient[DB.USED] = 0.0
		DB.emit_signal("ingredient_changed", _selected_ingredient)
		emit_signal("filter_changed", [_selected_ingredient])
