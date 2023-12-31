extends Control

signal filter_changed(books, utilities, ingredients)

const RECIPE_TEMPLATE := preload("res://recipe.tscn")
const SELECTION_TEMPLATE := preload("res://ingredient_selection.tscn")
#const DEFAULT_BOOKS := [DB.BOOK.SIMPLE]

#var _books: Array # Current selected cookbooks
var _books := [true, false, false, false, false, false, false, false, false, false] # Current selected cookbooks
var _utilities := [true, false, false, false, false] # Current selected utilities
var _ingredients: Array # Current selected ingredients
var _current_selection: Control
onready var _recipes = $HBoxContainer/VBoxContainer/Recipes/VBoxContainer/ScrollContainer/List
onready var _available_ingredients = $HBoxContainer/VBoxContainer/Ingredients/VBoxContainer/Grid
onready var _found_list = $FoundList


func _ready() -> void:
	for button in $HBoxContainer/Books/VBoxContainer/List.get_children():
		button.connect("toggled", self, "_on_filter_button_toggled", [_books, button])
	for button in $HBoxContainer/Utilities/VBoxContainer2/VBoxContainer.get_children():
		button.connect("toggled", self, "_on_filter_button_toggled", [_utilities, button])
	_found_list.connect("item_selected", self, "_on_search_item_selected")
	
	for data in DB.RECIPES:
		var recipe = RECIPE_TEMPLATE.instance()
		_recipes.add_child(recipe, true)
		recipe.activate(data)
		connect("filter_changed", recipe, "_on_filter_changed")
		
		for ingredient in data[DB.INGREDIENTS]:
			if ingredient.has(DB.GROUP):
				ingredient[DB.REGION] = DB.get_icon_region(ingredient[DB.ICON])
				for group_ingredient in ingredient[DB.GROUP]:
					_add_to_used_ingredients(group_ingredient)
			else:
				_add_to_used_ingredients(ingredient)
	
#	_books = DEFAULT_BOOKS
	_update_ingredients()

func _add_to_used_ingredients(ingredient: Dictionary):
	if not DB.USED_INGREDIENTS.has(ingredient):
		DB.USED_INGREDIENTS.append(ingredient)
		ingredient[DB.REGION] = DB.get_icon_region(ingredient[DB.ICON])

func _update_ingredients():
	var empty_selection: Control
	_ingredients.clear()
	for node in _available_ingredients.get_children():
		if node.ingredient.empty():
			if empty_selection:
				node.hide()
			else:
				empty_selection = node
				node.show()
		else:
			_ingredients.append(node.ingredient)
	if empty_selection == null:
		var selection = SELECTION_TEMPLATE.instance()
		selection.connect("search_string", self, "_on_search_string_changed", [selection])
		_available_ingredients.add_child(selection, true)
		selection.include.connect("toggled", self, "_on_include_changed", [selection])
	emit_signal("filter_changed", _books, _utilities, _ingredients)

# When one of filter buttons (books or utilities) was toggled
func _on_filter_button_toggled(pressed: bool, array: Array, button: Button):
	array[button.name as int] = pressed
	button.set("custom_styles/hover", button.get("custom_styles/%s" % "pressed" if pressed else "normal"))
	emit_signal("filter_changed", _books, _utilities, _ingredients)

func _on_search_string_changed(text: String, selection: Control):
	_found_list.hide()
	if text:
		_current_selection = selection
		var list_index := 0
		_found_list.clear()
		var lower_text = text.to_lower()
		for ingredient in DB.USED_INGREDIENTS:
			if lower_text in ingredient[DB.NAME].to_lower():
				_found_list.add_item(ingredient[DB.NAME], DB.ATLAS)
				_found_list.set_item_icon_region(list_index, ingredient[DB.REGION])
				_found_list.set_item_tooltip_enabled(list_index, false)
				_found_list.set_item_metadata(list_index, ingredient)
				list_index += 1
		_found_list.sort_items_by_text()
		_found_list.margin_top = _current_selection.rect_global_position.y + _current_selection.rect_size.y
		_found_list.margin_left = _current_selection.rect_global_position.x
		_found_list.visible = list_index > 0
	else:
		_current_selection = null
		selection.set_ingredient({})
		_update_ingredients()

func _on_search_item_selected(index: int):
	_found_list.hide()
	_current_selection.set_ingredient(_found_list.get_item_metadata(index))
	_update_ingredients()

func _on_include_changed(included: bool, selection: Control):
	selection.ingredient[DB.INCLUDE] = included
	emit_signal("filter_changed", _books, _utilities, _ingredients)
