extends Control

@onready var start_menu = $"."  # Reference StartMenu
@onready var close_button = get_node("Panel/Button")



func _ready():
	await get_tree().process_frame  # Wait a frame to ensure everything is loaded
	print(get_tree().get_nodes_in_group(""))  # List all nodes in the tree


	if close_button == null:
		print("ERROR: Button not found! Check your scene tree.")
	else:
		close_button.pressed.connect(_on_button_pressed)  # Connect button

	start_menu.visible = true  # Show menu on game start

func _on_button_pressed():
	print("Button Pressed!")  # Debugging
	start_menu.visible = false  # Hide menu when "Okay" is clicked
