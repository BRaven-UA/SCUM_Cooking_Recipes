extends Node

signal ingredient_changed(data)

enum {NAME, ICON, UNIT, GROUP, INGREDIENTS, AMOUNT, OPTIONAL, UTILITY, TIME, COOKBOOK, REGION, AVAILABLE, USED} # Dictionary keys
enum {PIECES, LITERS} # Units
enum {SKEWER, BBQ, PAN, POT, OWEN} # Utilities
enum BOOK {BBQ, CASSEROLES, PASTA, PIZZA, RICE, SOUP, STEW, CAKE, DRINKS} # Cookbooks

const ATLAS := preload("res://textures.png")
const ATLAS_WIDTH := 16
const ICON_SIZE := Vector2(64, 64)
const DEFAULT_FONT := preload("res://default_font.tres")
const TINY_FONT := preload("res://tiny_font.tres")

const ALL_INGREDIENTS := [] # will be filled at runtime

# Also each will contain REGION, AVAILABLE and USED keys
const GARLIC := {NAME: "Garlic", ICON: 0}
const TEA := {NAME: "Tea Pack", ICON: 0}
const GUTS := {NAME: "Guts", ICON: 0}
const WINE := {NAME: "Wine", ICON: 0}
const COFFEE := {NAME: "Coffee", ICON: 0}
const LIME := {NAME: "Lime", ICON: 0}
const VINEGAR := {NAME: "Vinegar", ICON: 0}
const PASTA := {NAME: "Pasta", ICON: 0}
const RABBIT_MEAT := {NAME: "Rabbit Meat", ICON: 0}
const CHOCOBAR := {NAME: "ChocoBar", ICON: 0}
const CHOCOLATE_BAR := {NAME: "Chocolate Bar", ICON: 0}
const C_C_BAR := {NAME: "Chocolate Candy Bar", ICON: 0}
const C_C_CANDY := {NAME: "Chocolate Cake Candy", ICON: 0}
const CHILLI := {NAME: "Chilli", ICON: 1}
const POTATO := {NAME: "Potato", ICON: 4}
const LEMON := {NAME: "Lemon", ICON: 5}
const CHOCCANDY := {NAME: "ChocCandy", ICON: 7}
const FLOUR := {NAME: "Flour", ICON: 8}
const BLACK_PEPPER := {NAME: "Black Pepper", ICON: 10}
const SUGAR := {NAME: "Sugar", ICON: 12}
const BEAR_STEAK := {NAME: "Bear Steak", ICON: 13}
const DEER_STEAK := {NAME: "Deer Steak", ICON: 13}
const DOE_STEAK := {NAME: "Doe Steak", ICON: 13}
const DONKEY_STEAK := {NAME: "Donkey Steak", ICON: 13}
const GOAT_STEAK := {NAME: "Goat Steak", ICON: 13}
const HORSE_STEAK := {NAME: "Horse Steak", ICON: 13}
const HUMAN_STEAK := {NAME: "Human Steak", ICON: 13}
const PORK_STEAK := {NAME: "Pork Steak", ICON: 13}
const WOLF_STEAK := {NAME: "Wolf Steak", ICON: 13}
const CABBAGE := {NAME: "Cabbage", ICON: 14}
const RICE := {NAME: "Rice", ICON: 15}
const WATER := {NAME: "Water", ICON: 16, UNIT: LITERS}
const SALT := {NAME: "Salt", ICON: 17}
const OIL := {NAME: "Oil", ICON: 18, UNIT: LITERS}
const CARROT := {NAME: "Carrot", ICON: 19}
const EGG := {NAME: "Egg", ICON: 20}
const CHICKEN_MEAT := {NAME: "Chicken Meat", ICON: 23}
const POULTRY_MEAT := {NAME: "Poultry Meat", ICON: 23}
const BREAD := {NAME: "Bread", ICON: 24}
const MUSTARD := {NAME: "Mustard", ICON: 27}
const DRUMSTICK := {NAME: "Chicken Drumstick", ICON: 28}
const CORN := {NAME: "Corn", ICON: 29}
const ONION := {NAME: "Onion", ICON: 30}
const PEPPER := {NAME: "Bell Pepper", ICON: 31}
const TOMATO := {NAME: "Tomato", ICON: 32}
const ZUCCHINI := {NAME: "Zucchini", ICON: 33}
const CREAM := {NAME: "Cream", ICON: 34}
const MILK := {NAME: "Milk", ICON: 35}
const SPICES := {NAME: "Mixed Spices", ICON: 36}
const SAUCE := {NAME: "Soy Sauce", ICON: 37}
const SEAFOOD := {NAME: "Seafood Mix", ICON: 39}
const PEAS := {NAME: "Peas", ICON: 40}
const AMUR_FILLET := {NAME: "Amur Fillet", ICON: 43}
const BASS_FILLET := {NAME: "Bass Fillet", ICON: 43}
const BLEAK_FILLET := {NAME: "Bleak Fillet", ICON: 43}
const CARP_FILLET := {NAME: "Carp Fillet", ICON: 43}
const CATFISH_FILLET := {NAME: "Catfish Fillet", ICON: 43}
const CHUB_FILLET := {NAME: "Chub Fillet", ICON: 43}
const DANTEX_FILLET := {NAME: "Dantex Fillet", ICON: 43}
const E_BASS_FILLET := {NAME: "European Bass Fillet", ICON: 43}
const ANGLER_FILLET := {NAME: "Angler Fillet", ICON: 43}
const ORATA_FILLET := {NAME: "Orata Fillet", ICON: 43}
const PIKE_FILLET := {NAME: "Pike Fillet", ICON: 43}
const RUFFE_FILLET := {NAME: "Ruffe Fillet", ICON: 43}
const SARDINE_FILLET := {NAME: "Sardine Fillet", ICON: 43}
const TUNA_FILLET := {NAME: "Tuna Fillet", ICON: 43}
const MUSHROOM_15 := {NAME: "Lycoperdon Gigantea", ICON: 44}
const MUSHROOM_14 := {NAME: "Lingzhi Mushroom", ICON: 45}
const MUSHROOM_13 := {NAME: "Fistula Hepatica", ICON: 46}
const MUSHROOM_12 := {NAME: "Coprinus Comatus", ICON: 47}
const MUSHROOM_11 := {NAME: "Psilocybe Cyanescens", ICON: 48}
const MUSHROOM_10 := {NAME: "Amanita Virosa", ICON: 49}
const MUSHROOM_9 := {NAME: "Amanita Phalloides", ICON: 50}
const MUSHROOM_8 := {NAME: "Amanita Pantherina", ICON: 51}
const MUSHROOM_7 := {NAME: "Amanita Muscaria", ICON: 52}
const MUSHROOM_6 := {NAME: "Lepiota Procera", ICON: 53}
const MUSHROOM_5 := {NAME: "Cantharellus Cibarius", ICON: 54}
const MUSHROOM_4 := {NAME: "Boletus Edulis", ICON: 55}
const MUSHROOM_3 := {NAME: "Armillaria Mellea", ICON: 56}
const MUSHROOM_2 := {NAME: "Agaricus Campestris", ICON: 57}
const MUSHROOM_1 := {NAME: "Agaricus Augustus", ICON: 58}
const ANY_MEAT := {NAME: "Any Meat", ICON: 13, GROUP: [BEAR_STEAK, DEER_STEAK, DOE_STEAK, DONKEY_STEAK, GOAT_STEAK, HORSE_STEAK, HUMAN_STEAK, PORK_STEAK, WOLF_STEAK, CHICKEN_MEAT, POULTRY_MEAT, RABBIT_MEAT]}
const MEAT := {NAME: "Meat", ICON: 13, GROUP: []}
const STEAK := {NAME: "Steak", ICON: 13, GROUP: []}
const ANY_FISH_FILLET := {NAME: "Any Fish Fillet", ICON: 0, GROUP: []}
const FISH_FILLET := {NAME: "Fish Fillet", ICON: 43, GROUP: [AMUR_FILLET, BASS_FILLET, BLEAK_FILLET, CARP_FILLET, CATFISH_FILLET, CHUB_FILLET, DANTEX_FILLET, E_BASS_FILLET, ANGLER_FILLET, ORATA_FILLET, PIKE_FILLET, RUFFE_FILLET, SARDINE_FILLET, TUNA_FILLET]}
const VEGETABLES := {NAME: "Vegetables", ICON: 31, GROUP: [PEPPER, CARROT, ONION, TOMATO, ZUCCHINI, CORN, POTATO, GARLIC]}
const LEMON_LIME := {NAME: "Lemon/Lime", ICON: 5, GROUP: [LEMON, LIME]}
const MUSHROOMS := {NAME: "Mushrooms", ICON: 58, GROUP: [MUSHROOM_1, MUSHROOM_2, MUSHROOM_3, MUSHROOM_4, MUSHROOM_5, MUSHROOM_6, MUSHROOM_7, MUSHROOM_8, MUSHROOM_9, MUSHROOM_10, MUSHROOM_11, MUSHROOM_12, MUSHROOM_13, MUSHROOM_14, MUSHROOM_15]}
const CHOCOLATE := {NAME: "Chocolate", ICON: 7, GROUP: [CHOCCANDY, CHOCOBAR, C_C_BAR, C_C_CANDY, CHOCOLATE_BAR]}

const RECIPES := [
	{NAME: "Meat Skewer", INGREDIENTS: [MEAT, SALT, BLACK_PEPPER], AMOUNT: [1, 1, 1], OPTIONAL: 1, UTILITY: SKEWER, TIME: 12}, 
	{NAME: "Fish Skewer", INGREDIENTS: [ANY_FISH_FILLET, SALT, BLACK_PEPPER], AMOUNT: [1, 1, 1], OPTIONAL: 1, UTILITY: SKEWER, TIME: 12}, 
	{NAME: "Mixed Skewer", INGREDIENTS: [MEAT, VEGETABLES, MUSHROOMS, SALT, BLACK_PEPPER], AMOUNT: [1, 1, 1, 2, 2], OPTIONAL: 3, UTILITY: SKEWER, TIME: 10}, 
	{NAME: "Vegetable Skewer", INGREDIENTS: [VEGETABLES, MUSHROOMS, SALT, BLACK_PEPPER, VEGETABLES, VEGETABLES], AMOUNT: [1, 1, 2, 2, 1, 1], OPTIONAL: 2, UTILITY: SKEWER, TIME: 8}, 
	{NAME: "Grilled Red Meat", INGREDIENTS: [STEAK, SALT, BLACK_PEPPER], AMOUNT: [1, 1, 1], OPTIONAL: 1, UTILITY: BBQ, TIME: 8}, 
	{NAME: "Poultry Drumstick", INGREDIENTS: [DRUMSTICK, SALT, BLACK_PEPPER], AMOUNT: [1, 1, 1], OPTIONAL: 1, UTILITY: BBQ, TIME: 15}, 
	{NAME: "Grilled Poultry Meat", INGREDIENTS: [POULTRY_MEAT, SALT, BLACK_PEPPER], AMOUNT: [1, 1, 1], OPTIONAL: 1, UTILITY: BBQ, TIME: 8}, 
	{NAME: "Grilled Sausage", INGREDIENTS: [STEAK, GUTS, SALT, MUSTARD, BLACK_PEPPER], AMOUNT: [1, 1, 1, 1, 1], OPTIONAL: 2, UTILITY: BBQ, TIME: 4}, 
	{NAME: "Grilled Fish", INGREDIENTS: [FISH_FILLET, SALT, OIL, FISH_FILLET], AMOUNT: [1, 1, 0.1, 1], OPTIONAL: 1, UTILITY: BBQ, TIME: 5}, 
	{NAME: "Grilled Mushroom", INGREDIENTS: [MUSHROOMS, SALT, BLACK_PEPPER, MUSHROOMS, MUSHROOMS, MUSHROOMS, MUSHROOMS], AMOUNT: [1, 1, 1, 1, 1, 1, 1], OPTIONAL: 1, UTILITY: BBQ, TIME: 5}, 
	{NAME: "Grilled Veggie", INGREDIENTS: [VEGETABLES, SALT, BLACK_PEPPER, VEGETABLES, VEGETABLES, VEGETABLES, VEGETABLES], AMOUNT: [1, 1, 1, 1, 1, 1, 1], OPTIONAL: 1, UTILITY: BBQ, TIME: 1}, 
	{NAME: "Cevapi", INGREDIENTS: [STEAK, BREAD, SALT, BLACK_PEPPER, ONION], AMOUNT: [1, 2, 1, 1, 1], OPTIONAL: 2, UTILITY: BBQ, TIME: 10}, 
	{NAME: "Fried Eggs", INGREDIENTS: [EGG, SALT, OIL, EGG, EGG, EGG], AMOUNT: [1, 1, 0.1, 1, 1, 1], OPTIONAL: 1, UTILITY: PAN, TIME: 5},
	{NAME: "Szechuan Noodles", INGREDIENTS: [PASTA, WATER, MEAT, MEAT, CHILLI, PEPPER, ONION, SALT, OIL, SPICES, SAUCE, VINEGAR], AMOUNT: [1, 0.1, 1, 1, 1, 1, 1, 2, 0.2, 2, 0.2, 0.25], OPTIONAL: 7, UTILITY: PAN, TIME: 60},
	{NAME: "Cabbage Rolls", INGREDIENTS: [STEAK, STEAK, CABBAGE, RICE, WATER, SALT, BLACK_PEPPER, OIL, FLOUR, CARROT], AMOUNT: [1, 1, 1, 4, 1.0, 2, 2, 0.2, 2, 1], OPTIONAL: 5, UTILITY: POT, TIME: 180}, 
	{NAME: "Meat Stew", INGREDIENTS: [STEAK, WATER, VEGETABLES, VEGETABLES, VEGETABLES, MUSHROOMS, SALT, OIL, STEAK, PEAS, WINE], AMOUNT: [1, 1.0, 1, 1, 1, 1, 2, 0.3, 1, 2, 0.5], OPTIONAL: 6, UTILITY: POT, TIME: 90}, 
	{NAME: "Jambalaya", INGREDIENTS: [ANY_MEAT, ANY_MEAT, VEGETABLES, SEAFOOD, GARLIC, RICE, WATER, OIL, SPICES, CHILLI, SALT, BLACK_PEPPER], AMOUNT: [1, 1, 1, 1, 1, 4, 1.0, 0.3, 4, 1, 2, 2], OPTIONAL: 7, UTILITY: POT, TIME: 60},
	{NAME: "Tea", INGREDIENTS: [TEA, WATER, SUGAR, LEMON_LIME], AMOUNT: [1, 0.5, 1, 1], OPTIONAL: 2, UTILITY: POT, TIME: 3},
	{NAME: "Coffee Black", INGREDIENTS: [COFFEE, WATER, SUGAR], AMOUNT: [1, 0.5, 1], OPTIONAL: 2, UTILITY: POT, TIME: 5},
	{NAME: "Coffee Espresso Con Panna", INGREDIENTS: [COFFEE, WATER, MILK, CREAM, SUGAR], AMOUNT: [1, 0.5, 0.1, 1, 1], OPTIONAL: 4, UTILITY: POT, TIME: 5},
	{NAME: "Hot Chocolate", INGREDIENTS: [CREAM, CHOCOLATE, MILK, SUGAR], AMOUNT: [1, 1, 0.5, 1], OPTIONAL: 3, UTILITY: POT, TIME: 10}
	]

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
