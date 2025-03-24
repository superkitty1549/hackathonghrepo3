extends Node

var slime_textures = {}  # Stores textures for slimes by their unique ID

func save_slime_texture(slime_id, texture_path):
	slime_textures[slime_id] = texture_path

func get_slime_texture(slime_id):
	return slime_textures.get(slime_id, null)  # Return saved texture path if exists
