extends Panel

const INGREDIENT_TEMPLATE := preload("res://ingredient.tscn")

var _data: Dictionary
var _ingredients_and_groups: Array
onready var _container = $ScrollContainer/Ingredients


func activate(data: Dictionary):
	_data = data
	$Name.text = _data[DB.NAME]
	for index in _data[DB.INGREDIENTS].size():
		var ingredient = INGREDIENT_TEMPLATE.instance()
		var ingredient_data = _data[DB.INGREDIENTS][index]
		_ingredients_and_groups.append(ingredient_data)
		if ingredient_data.has(DB.GROUP):
			_ingredients_and_groups.append_array(ingredient_data[DB.GROUP])
		_container.add_child(ingredient, true)
		ingredient.activate(ingredient_data, _data[DB.AMOUNT][index])
		if index == _data[DB.OPTIONAL]:
			ingredient.size_flags_horizontal = SIZE_EXPAND + SIZE_SHRINK_END

func _on_filter_changed(books: Array, ingredients: Array):
#	visible = ingredients.empty()
	if ingredients.empty() and books[_data[DB.COOKBOOK]]:
		show()
		return
	else:
		for ingredient in ingredients:
			if ingredient in _ingredients_and_groups and books[_data[DB.COOKBOOK]]:
				visible = true
				return
	hide()
