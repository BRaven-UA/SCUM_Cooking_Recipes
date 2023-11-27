tool
extends EditorScript


func _run() -> void:
	for id in DB.INGREDIENTS:
		print(id)
