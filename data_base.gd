class_name DB
extends Resource

enum {NAME, ICON, UNIT, MAIN_INGREDIENTS, OPTIONAL_INGREDIENTS, UTILITY, TIME, AVAILABLE, USED} # Dictionary keys
enum {PIECES, LITERS} # Units
enum ID {NONE, WATER, SALT, BLACK_PEPPER, FLOUR, CABBAGE, RICE, OIL, CARROT, STEAK, BEAR_STEAK, CARP_STEAK} # Ingredient IDs (used as enumerator in export dropdown menues)
enum {POT, OWEN} # Utilities

const INGREDIENTS := {
	ID.WATER: {NAME: "Water", ICON: 16, UNIT: LITERS},
	ID.STEAK: {NAME: "Steak", ICON: 13},
	ID.CABBAGE: {NAME: "Cabbage", ICON: 14},
	ID.RICE: {NAME: "Rice", ICON: 15},
	ID.SALT: {NAME: "Salt", ICON: 17},
	ID.BLACK_PEPPER: {NAME: "Black Pepper", ICON: 10},
	ID.OIL: {NAME: "Oil", ICON: 18, UNIT: LITERS},
	ID.CARROT: {NAME: "Carrot", ICON: 19},
	ID.FLOUR: {NAME: "Flour", ICON: 8}
	}
const GROUPS := {ID.STEAK: [ID.BEAR_STEAK, ID.CARP_STEAK]}
#const RECIPES := {
#	"Cabbage Rolls": {
#		MAIN_INGREDIENTS: [{STEAK: 1}, {STEAK: 1}, {CABBAGE: 1}, {RICE: 4}, {WATER: 1.0}],
#		OPTIONAL_INGREDIENTS: {SALT: 2, BLACK_PEPPER: 2},
#		UTILITY: POT, TIME: 180}
#	}
const ATLAS := preload("res://textures.png")
const ATLAS_WIDTH := 16
const ICON_SIZE := Vector2(64, 64)
const DEFAULT_FONT := preload("res://default_font.tres")
const TINY_FONT := preload("res://tiny_font.tres")

#func _init() -> void:
#	INGREDIENTS.WATER

# Returns ingredient data by the specified name
static func get_data_by_name(name: String) -> Dictionary:
	for data in INGREDIENTS.values():
		if data[NAME] == name:
			return data
	return {}

static func get_icon_region(id: int) -> Rect2:
	var index = INGREDIENTS[id][ICON]
	return Rect2(ICON_SIZE * Vector2(index % ATLAS_WIDTH, index / ATLAS_WIDTH), ICON_SIZE)
