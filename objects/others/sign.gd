extends Node2D

@export var messages: Array[String] = ["Hello, traveler!", "This is a sign.", "Press E to interact, and Enter to continue."]

var player_near = false
var message_index = 0

@onready var dialog_ui = $DialogUI  # Ensure this node exists!
@onready var dialog_text = $DialogUI/RichTextLabel
@onready var area = $Area2D  # Ensure this exists!

func _ready():
	dialog_ui.visible = false  # Hide dialog at start
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		print("E Pressed!")  # Debugging

	if player_near:
		print("✅ player_near is TRUE")  # Debugging

	if player_near and Input.is_action_just_pressed("interact"):
		print("🎬 Starting dialogue!")
		start_dialog()

func start_dialog():
	print("📜 Showing dialogue!")  # Debugging
	dialog_ui.visible = true
	message_index = 0
	show_message()

func show_message():
	if message_index < messages.size():
		dialog_text.text = messages[message_index]
	else:
		dialog_ui.visible = false  # Hide when finished

func _on_body_entered(body):
	if body.name == "Player":
		player_near = true
		print("🚶 Player entered sign area")

func _on_body_exited(body):
	if body.name == "Player":
		player_near = false
		print("🚶 Player left sign area")
