extends Panel

const INGREDIENT_TEMPLATE := preload("res://ingredient.tscn")

var _data: Dictionary
onready var _container = $Ingredients


func activate(data: Dictionary):
	_data = data
	$Name.text = _data[DB.NAME]
	for index in _data[DB.INGREDIENTS].size():
		var ingredient = INGREDIENT_TEMPLATE.instance()
		_container.add_child(ingredient, true)
		ingredient.activate(_data[DB.INGREDIENTS][index], _data[DB.AMOUNT][index])
		if index == _data[DB.OPTIONAL]:
			ingredient.size_flags_horizontal = SIZE_EXPAND + SIZE_SHRINK_END

func _on_main_filter_changed(ingredients: Array):
#	visible = ingredients.empty()
	if ingredients.empty():
		show()
	else:
		for ingredient in ingredients:
			if ingredient in _data[DB.INGREDIENTS]:
				visible = true
				return
