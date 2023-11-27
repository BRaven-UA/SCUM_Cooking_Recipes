extends Node

signal ingredient_changed(data)

enum {NAME, ICON, UNIT, INGREDIENTS, AMOUNT, OPTIONAL, UTILITY, TIME, REGION, AVAILABLE, USED} # Dictionary keys
enum {PIECES, LITERS} # Units
#enum ID {NONE, WATER, SALT, BLACK_PEPPER, MIXED_SPICES, FLOUR, CABBAGE, CHILLI, RICE, OIL, CARROT, ANY_MEAT, STEAK, BEAR_STEAK, CARP_STEAK, CHICKEN_MEAT, VEGETABLES, SEAFOOD_MIX, GARLIC} # Ingredient IDs (used as enumerator in export dropdown menues)
enum {POT, OWEN} # Utilities

#const TEST := ["Water", "Steak", "Cabbage"]
#const TEST2 := {"Water": INGREDIENTS}#, "Steak": 2, "Cabbage": 3, "Mixed Spices": 4, "Black Pepper": 5}
#const INGREDIENTS := {
#	ID.WATER: {NAME: "Water", ICON: 16, UNIT: LITERS},
#	ID.STEAK: {NAME: "Steak", ICON: 13},
#	ID.CABBAGE: {NAME: "Cabbage", ICON: 14},
#	ID.RICE: {NAME: "Rice", ICON: 15},
#	ID.SALT: {NAME: "Salt", ICON: 17},
#	ID.BLACK_PEPPER: {NAME: "Black Pepper", ICON: 10},
#	ID.OIL: {NAME: "Oil", ICON: 18, UNIT: LITERS},
#	ID.CARROT: {NAME: "Carrot", ICON: 19},
#	ID.CHILLI: {NAME: "Chilli", ICON: 1},
#	ID.MIXED_SPICES: {NAME: "Mixed Spices", ICON: 0},
#	ID.CHICKEN_MEAT: {NAME: "Chicken Meat", ICON: 0},
#	ID.GARLIC: {NAME: "Garlic", ICON: 0},
#	ID.SEAFOOD_MIX: {NAME: "Seafood Mix", ICON: 0},
#	ID.VEGETABLES: {NAME: "Vegetables", ICON: 0},
#	ID.ANY_MEAT: {NAME: "Any Meat", ICON: 0},
#	ID.FLOUR: {NAME: "Flour", ICON: 8}
#	}
#const INGREDIENTS := {
#	"Water": {ICON: 16, UNIT: LITERS},
#	"Steak": {ICON: 13},
#	"Cabbage_dd": {ICON: 14}
#	}

# Also each will contain REGION, AVAILABLE and USED keys
const WATER := {NAME: "Water", ICON: 16, UNIT: LITERS}
const STEAK := {NAME: "Steak", ICON: 13}
const CABBAGE := {NAME: "Cabbage", ICON: 14}
const RICE := {NAME: "Rice", ICON: 15}
const SALT := {NAME: "Salt", ICON: 17}
const BLACK_PEPPER := {NAME: "Black Pepper", ICON: 10}
const OIL := {NAME: "Oil", ICON: 18, UNIT: LITERS}
const FLOUR := {NAME: "Flour", ICON: 8}
const CARROT := {NAME: "Carrot", ICON: 19}
#const GROUPS := {
#	ID.STEAK: [ID.BEAR_STEAK, ID.CARP_STEAK],
#	ID.VEGETABLES: [],
#	ID.ANY_MEAT: [ID.BEAR_STEAK, ID.CARP_STEAK, ID.CHICKEN_MEAT]
#}
const RECIPES := [
	{NAME: "Cabbage Rolls", INGREDIENTS: [STEAK, STEAK, CABBAGE, RICE, WATER, SALT, BLACK_PEPPER, OIL, FLOUR, CARROT], AMOUNT: [1, 1, 1, 4, 1.0, 2, 2, 0.2, 2, 1], OPTIONAL: 5, UTILITY: POT, TIME: 180}
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
