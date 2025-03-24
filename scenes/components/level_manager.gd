extends Node

signal level_changed(old_level: String, new_level: String)

@onready var game: Node = get_tree().root.get_node("Game")

var level_root: Node2D
var current_level: Node2D

func _ready() -> void:
	level_root = game.find_child("LevelRoot")
	assert(level_root)
	current_level = level_root.get_child(0)
	assert(current_level)

func change_level(next_level_path: String) -> void:
	print("\n=== Changing Level ===")
	print("Requested Level Path:", next_level_path)

	# Load the new level
	var next_level_res = load(next_level_path)
	if next_level_res == null:
		print("ERROR: Failed to load level! Check the path:", next_level_path)
		return

	var next_level = next_level_res.instantiate()
	if next_level == null:
		print("ERROR: Failed to instantiate the new level!")
		return

	print("Level Loaded Successfully:", next_level_path)

	var player = game.get_node("World/Player")
	if player == null:
		print("ERROR: Player node not found!")
		return

	# Try to locate the correct spawn portal
	var portals = next_level.find_child("Portals")
	if portals == null:
		print("⚠WARNING: No 'Portals' node found in new level! Placing player at (0,0).")
		player.position = Vector2.ZERO
	else:
		print("Searching for matching portal...")
		var portal_found = false
		for portal in portals.get_children():
			if not portal.has_method("get_destination"):
				print("⚠WARNING: Portal is missing 'get_destination' method.")
				continue
			if portal.get_destination() == current_level.scene_file_path:
				print("Portal Matched! Moving player to:", portal.spawn_point.global_position)
				player.position = portal.spawn_point.global_position
				portal_found = true
				break
		
		if not portal_found:
			print("⚠WARNING: No matching portal found! Placing player at (0,0).")
			player.position = Vector2.ZERO

	# Remove previous level
	if current_level:
		print("Removing previous level:", current_level.scene_file_path)
		current_level.queue_free()
	else:
		print("WARNING: No current level found!")

	# Attach new level
	level_root.call_deferred("add_child", next_level)
	level_changed.emit(current_level.scene_file_path if current_level else "Unknown", next_level.scene_file_path)

	current_level = next_level
	print("Level change complete!\n")
