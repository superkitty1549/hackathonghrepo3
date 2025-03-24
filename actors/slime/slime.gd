extends Actor

@onready var sprite : Sprite2D = $Sprite2D
@onready var detection_area : DetectionArea = $DetectionArea
@onready var interaction_icon : Sprite2D = get_node_or_null("InteractionIcon")  # Avoids crash if missing

var sprite_map = {
	preload("res://assets/sprites/characters/darkkami.png"): preload("res://assets/sprites/characters/kami.png"),
	preload("res://assets/sprites/characters/darknip.png"): preload("res://assets/sprites/characters/nip.png"),
	preload("res://assets/sprites/characters/darkbiscuits.png"): preload("res://assets/sprites/characters/biscuits.png"),
	preload("res://assets/sprites/characters/darkscoutf.png"): preload("res://assets/sprites/characters/scoutf.png"),
	preload("res://assets/sprites/characters/darklamber.png"): preload("res://assets/sprites/characters/lamber.png"),
}

static var assigned_sprites = []  
var is_transformed = false
var player_nearby = false  

func _ready():
	# Assign unique spritesheet
	for texture in sprite_map.keys():
		if texture not in assigned_sprites:
			sprite.texture = texture
			assigned_sprites.append(texture)
			break  

	# Ensure Interaction Icon is hidden at start
	if interaction_icon:
		interaction_icon.visible = false  

	set_physics_process(false)  # Stops movement

func _on_health_health_depleted() -> void:
	if not is_transformed:
		is_transformed = true  
		if sprite.texture in sprite_map:
			sprite.texture = sprite_map[sprite.texture]  
		set_physics_process(false)  # Stop movement forever
	else:
		queue_free()  

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		player_nearby = true
		if interaction_icon:
			interaction_icon.visible = true  

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		player_nearby = false
		if interaction_icon:
			interaction_icon.visible = false  

func _input(event):
	if event.is_action_pressed("interact") and player_nearby:
		go_to_next_level()

func go_to_next_level():
	get_tree().change_scene_to_file("res://scenes/level2.tscn")
