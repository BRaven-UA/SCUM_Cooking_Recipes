extends Node

signal ingredient_changed(data)

enum {NAME, ICON, UNIT, INGREDIENTS, AMOUNT, OPTIONAL, UTILITY, TIME, REGION, AVAILABLE, USED} # Dictionary keys
enum {PIECES, LITERS} # Units
enum {POT, OWEN} # Utilities

const ALL_INGREDIENTS := [] # will be filled at runtime

# Also each will contain REGION, AVAILABLE and USED keys
const WATER := {NAME: "Water", ICON: 16, UNIT: LITERS}
const ANY_MEAT := {NAME: "Any Meat", ICON: 13}
const STEAK := {NAME: "Steak", ICON: 13}
const SEAFOOD := {NAME: "Seafood Mix", ICON: 39}
const VEGETABLES := {NAME: "Vegetables", ICON: 31}
const GARLIC := {NAME: "Garlic", ICON: 0}
const CHILLI := {NAME: "Chilli", ICON: 1}
const CABBAGE := {NAME: "Cabbage", ICON: 14}
const CARROT := {NAME: "Carrot", ICON: 19}
const RICE := {NAME: "Rice", ICON: 15}
const SALT := {NAME: "Salt", ICON: 17}
const SPICES := {NAME: "Mixed Spices", ICON: 36}
const BLACK_PEPPER := {NAME: "Black Pepper", ICON: 10}
const OIL := {NAME: "Oil", ICON: 18, UNIT: LITERS}
const FLOUR := {NAME: "Flour", ICON: 8}
#const GROUPS := {
#	ID.STEAK: [ID.BEAR_STEAK, ID.CARP_STEAK],
#	ID.VEGETABLES: [],
#	ID.ANY_MEAT: [ID.BEAR_STEAK, ID.CARP_STEAK, ID.CHICKEN_MEAT]
#}
const RECIPES := [
	{NAME: "Cabbage Rolls", INGREDIENTS: [STEAK, STEAK, CABBAGE, RICE, WATER, SALT, BLACK_PEPPER, OIL, FLOUR, CARROT], AMOUNT: [1, 1, 1, 4, 1.0, 2, 2, 0.2, 2, 1], OPTIONAL: 5, UTILITY: POT, TIME: 180}, 
	{NAME: "Jambalaya", INGREDIENTS: [ANY_MEAT, ANY_MEAT, VEGETABLES, SEAFOOD, GARLIC, RICE, WATER, OIL, SPICES, CHILLI, SALT, BLACK_PEPPER], AMOUNT: [1, 1, 1, 1, 1, 4, 1.0, 0.3, 4, 1, 2, 2], OPTIONAL: 7, UTILITY: POT, TIME: 60}
	]
const ATLAS := preload("res://textures.png")
const ATLAS_WIDTH := 16
const ICON_SIZE := Vector2(64, 64)
const DEFAULT_FONT := preload("res://default_font.tres")
const TINY_FONT := preload("res://tiny_font.tres")

#func _init() -> void:
#	INGREDIENTS.Cabbage_dd

# Returns ingredient data by the specified name
#static func get_data_by_name(name: String) -> Dictionary:
#	for data in INGREDIENTS.values():
#		if data[NAME] == name:
#			return data
#	return {}

static func get_icon_region(index: int) -> Rect2:
#	var index = INGREDIENTS[id][ICON]
	return Rect2(ICON_SIZE * Vector2(index % ATLAS_WIDTH, index / ATLAS_WIDTH), ICON_SIZE)
