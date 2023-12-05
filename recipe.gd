extends Panel

const INGREDIENT_TEMPLATE := preload("res://ingredient.tscn")
const OPTIONAL_COLOR := Color("#425a5c")

var _data: Dictionary
var _ingredients_and_groups: Array
onready var _main = $MainIngredients
onready var _optional = $OptionalIngredients


func activate(data: Dictionary):
	_data = data
	$Name.text = _data[DB.NAME]
	$Time.text = "%d min" % _data[DB.TIME]
	
	for index in _data[DB.INGREDIENTS].size():
		var ingredient = INGREDIENT_TEMPLATE.instance()
		var ingredient_data = _data[DB.INGREDIENTS][index]
		_ingredients_and_groups.append(ingredient_data)
		if ingredient_data.has(DB.GROUP):
			_ingredients_and_groups.append_array(ingredient_data[DB.GROUP])
		if index < _data[DB.OPTIONAL]:
			_main.add_child(ingredient, true)
		else:
			ingredient.tint_under = OPTIONAL_COLOR
			_optional.add_child(ingredient, true)
		ingredient.activate(ingredient_data, _data[DB.AMOUNT][index])
	
	var utility = preload("res://utility.tscn").instance()
	add_child(utility, true)
	utility.activate(_data[DB.UTILITY])

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
