extends Control

signal filter_changed(ingredients)

const RECIPE_TEMPLATE := preload("res://recipe.tscn")
const SELECTION_TEMPLATE := preload("res://ingredient_selection.tscn")

var _current_selection: Control
onready var _recipes = $RightSide/Recipes
onready var _available_ingredients = $Ingredients
onready var _found_list = $FoundList


func _ready() -> void:
	_found_list.connect("item_selected", self, "_on_search_item_selected")
	
	for data in DB.RECIPES:
		var recipe = RECIPE_TEMPLATE.instance()
		_recipes.add_child(recipe, true)
		recipe.activate(data)
		connect("filter_changed", recipe, "_on_main_filter_changed")
		
		for ingredient in data[DB.INGREDIENTS]:
			if not DB.ALL_INGREDIENTS.has(ingredient):
				DB.ALL_INGREDIENTS.append(ingredient)
	
	_update_available()

func _update_available():
	var empty_selection: Control
	for node in _available_ingredients.get_children():
		if node.ingredient.empty():
			if empty_selection:
				node.hide()
			else:
				empty_selection = node
	if empty_selection == null:
		var selection = SELECTION_TEMPLATE.instance()
		selection.connect("filter_changed", self, "_on_filter_changed", [selection])
		_available_ingredients.add_child(selection, true)

func _on_filter_changed(text: String, selection: Control):
	_found_list.hide()
	if text:
		_current_selection = selection
		var list_index := 0
		_found_list.clear()
		var lower_text = text.to_lower()
		for ingredient in DB.ALL_INGREDIENTS:
			if lower_text in ingredient[DB.NAME].to_lower():
				_found_list.add_item(ingredient[DB.NAME], DB.ATLAS)
				_found_list.set_item_icon_region(list_index, ingredient[DB.REGION])
				_found_list.set_item_tooltip_enabled(list_index, false)
				_found_list.set_item_metadata(list_index, ingredient)
				list_index += 1
		_found_list.sort_items_by_text()
		_found_list.rect_global_position = _current_selection.rect_global_position + Vector2(0, _current_selection.rect_size.y)
		_found_list.visible = list_index > 0
	else:
		_current_selection = null
		selection.set_ingredient({})
		_update_available()

func _on_search_item_selected(index: int):
	_found_list.hide()
	_current_selection.set_ingredient(_found_list.get_item_metadata(index))
	_update_available()
